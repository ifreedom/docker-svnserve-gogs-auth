#!/usr/bin/env python

import httplib
import base64
import string
import sys
import os
from urlparse import urlparse
from ConfigParser import ConfigParser

DEBUG = False

ini = ConfigParser()
ini.read("/etc/gogs_auth.conf")

host = ini.get("Auth", "GOGS_HOST")
username = os.environ['PAM_USER']
password = sys.stdin.read().rstrip()

conn = None
uri = urlparse(host)
if uri.scheme == "http":
    conn = httplib.HTTPConnection(uri.netloc)
else:
    conn = httplib.HTTPSConnection(uri.netloc)

auth = base64.encodestring('%s:%s' % (username, password)).replace('\n', '')
headers = {
    "Authorization": "Basic %s" % auth
}
conn.request('GET', '/api/v1/user/emails', None, headers)
resp = conn.getresponse()
ret = resp.status
if DEBUG:
    print(host)
    print(username)
    print(password)
    print(ret)
    print(resp.read())
conn.close()
if ret == httplib.OK:
    exit(0)
else:
    exit(1)
