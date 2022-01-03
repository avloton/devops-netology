#!/usr/bin/env python3

import json
import socket
import time
import yaml

dns_names = {'drive.google.com': '', 'mail.google.com': '', 'google.com': ''}

while True:

    print('---------------')

    services = {'services': []}

    for dns_name, old_ip in dns_names.items():
        time.sleep(1)
        new_ip = socket.gethostbyname(dns_name)
        print('http://' + dns_name + ' - ' + new_ip)
        dns_names[dns_name] = new_ip

        if len(old_ip) == 0:
            continue
        elif old_ip != new_ip:
            print('[ERROR] http://' + dns_name + ' IP mismatch: ' + old_ip + ' ' + new_ip)

        services['services'].append({dns_name: new_ip})

    with open('dns_names.json', 'w') as jsfile:
        json.dump(services, jsfile)

    with open('dns_names.yml', 'w') as ymlfile:
        yaml.dump(services, ymlfile)
