#!/usr/bin/env python

"""
This should probably be put into a pip package or .rpm and deployed that way, but
for now, this will do.

"""

import argparse
import subprocess

DEFAULT_DOMAIN = 'tylerjachetta.net'

KEY_HIERA_CONFIG = 'hiera_config'

PUPPET_CONFIG_OUT_DELIM = ' = '

# Classes


class PuppetConfig(object):

    _instance = None

    def __new__(cls, *args, **kwargs):
        if not cls._instance:
            cls._instance = super(PuppetConfig, cls).__new__(cls, *args, **kwargs)
        return cls._instance

    def __init__(self):
        self._all_items = {}

        self._fetch()

    def _fetch(self):

        cmd = ['puppet', 'config', 'print']
        raw_out = subprocess.check_output(cmd)

        new_vals = {}

        for line in raw_out.splitlines():
            if not line.strip():
                continue

            if PUPPET_CONFIG_OUT_DELIM not in line:
                # TODO better logging
                print('unrecognized format for puppet config output: {0}'.format(line))

            key, val = [item.strip() for item in line.split(PUPPET_CONFIG_OUT_DELIM, 1)]
            new_vals[key] = val

        self._all_items = new_vals

    def get(self, key):
        # TODO put in some timeout for fetching values
        # TODO might want to wrap the keyerror here and give it a gussied up
        # exception, but then again might not.
        return self._all_items[key]


# internal helper functions


def _parse_args():
    parser = argparse.ArgumentParser()

    parser.add_argument('node_name')

    args = parser.parse_args()

    return args


def _get_hiera_config_path():
    return PuppetConfig().get(KEY_HIERA_CONFIG)


def collect_modules(node_name):
    # TODO
    pass


def create_props_dict(node_name):
    # TODO
    pass


def run():
    args = _parse_args()

    node_name = args.node_name

    props_dict = create_props_dict(node_name)
    modules = collect_modules(node_name, props_dict)



if __name__ == '__main__':
    run()
