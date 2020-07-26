#!/usr/bin/python

# This script requires that your email account details are stored
# inside the pass (http://www.passwordstore.org/) password manager
# in a subfolder called email (one file per account). Every file
# has the following format:
#
# y0ur-p4ssw0rd
# User: your-user
# IMAP: your.imap-server.domain
# -- OR --
# POP3: your.pop3-server.domain
# SMTP: your.smtp-server.domain

from imaplib import IMAP4, IMAP4_SSL
from poplib import POP3, POP3_SSL
import subprocess, pickle, time, sys, os, socket

def get_credentials(name):
    # run this in shell so gpg-agent can hook in
    ds = subprocess.run('pass show email/' + name, stdout=subprocess.PIPE, shell=True).stdout.decode('utf-8')
    ds = ds.strip().splitlines()
    if len(ds) == 0:
        return None
    password = ds[0]
    info = {i[0]: i[1] for i in (s.split(': ', 1) for s in ds[1:])}
    if 'IMAP' not in info and 'POP3' not in info:
        return None
    if 'User' not in info:
        return None
    if 'IMAP' in info:
        return 'imap', info['IMAP'], info['User'], password
    if 'POP3' in info:
        return 'pop3', info['POP3'], info['User'], password
    return None

class MailChecker(object):
    def __init__(self):
        self.check_interval = 30
        self.cache_file = '/tmp/.check-mail'
        path = os.path.expanduser('~/.password-store/email')
        acctnames = (f[:-4] for f in os.listdir(path) if f.endswith('.gpg'))
        self.accounts = {}
        for acct in acctnames:
            creds = get_credentials(acct)
            if creds is not None:
                self.accounts[acct] = creds

    def is_connected(self):
      try:
        host = socket.gethostbyname('google.com')
        s = socket.create_connection((host, 80), 2)
        return True
      except:
         pass
      return False

    def check(self, creds):
        proto, domain, user, password = creds
        if proto == 'imap':
            with IMAP4_SSL(domain) as M:
                try:
                    M.login(user, password)
                    ok, status = M.status('INBOX', '(MESSAGES UNSEEN)')
                    if ok != 'OK':
                        return None
                    return int(status[0].strip().decode('utf-8').split(None, 1)[1][1:-1].split(None)[3])
                except:
                    return None
        elif proto == 'pop3':
            with POP3_SSL(domain) as M:
                try:
                    M.user(user)
                    M._pass(password)
                    count, _ = M.stat()
                    return count
                except:
                    return None
        return None

    def update(self):
        if os.fork() == 0:
            with open(self.cache_file + '.running', 'a'):
                os.utime(self.cache_file + '.running', None)
            accts = {}
            if self.is_connected():
                accts = {acct: self.check(creds) for acct, creds in self.accounts.items()}
            check = {'last_check': int(time.time()), 'accounts': accts}
            with open(self.cache_file, 'wb') as cache:
                pickle.dump(check, cache, pickle.HIGHEST_PROTOCOL)
            os.remove(self.cache_file + '.running')
            os._exit(0)

    def current_status(self):
        check = {'last_check': 0, 'accounts': {}}
        if os.path.exists(self.cache_file):
            with open(self.cache_file, 'rb') as cache:
                check = pickle.load(cache)
        if int(time.time()) - check['last_check'] > self.check_interval * 60:
            if not os.path.exists(self.cache_file + '.running'):
                self.update()
        accounts = check['accounts']
        return accounts

    def format_polybar(self):
        mailstatus = self.current_status()
        account_format = "%{F#777}"
        num_format = "%{F-}"
        reset_format = "%{F-}"
        return "  ".join(f"{account_format}{acct}{reset_format} {num_format}{mails}{reset_format}" for acct, mails in mailstatus.items() if mails > 0)

    def check_has_mails(self):
        mailstatus = self.current_status()
        return any(mails > 0 for mails in mailstatus.values())

if __name__ == '__main__':
    if len(sys.argv) < 2:
        sys.exit(1)
    if sys.argv[1] == "has_mails":
        checker = MailChecker()
        if checker.check_has_mails():
            sys.exit(0)
        else:
            sys.exit(1)
    elif sys.argv[1] == "polybar":
        checker = MailChecker()
        print(checker.format_polybar())
