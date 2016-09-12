from ansible import utils, errors
import boto.ec2

# pylint: disable=no-name-in-module,import-error,unused-argument,unused-variable,super-init-not-called,too-few-public-methods,missing-docstring
try:
    # ansible-2.0
    from ansible.plugins.lookup import LookupBase
except ImportError:
    # ansible-1.9.x
    class LookupBase(object):
        def __init__(self, basedir=None, runner=None, **kwargs):
            self.runner = runner
            self.basedir = self.runner.basedir
            def get_basedir(self, variables):
                return self.basedir


class LookupModule(LookupBase):
    def __init__(self, basedir=None, **kwargs):
        self.basedir = basedir

    def run(self, region, inject=None, **kwargs):
        if isinstance(region, list):
            region = region[0]

        if not isinstance(region, basestring):
            raise errors.AnsibleError("type of region is: %s region is: %s" %
                    (type(region), region))

        try:
            conn = boto.ec2.connect_to_region(region)
            if conn is None:
                raise errors.AnsibleError("Could not connet to region %s" % region)
            zones = [z.name for z in conn.get_all_zones()]
	    if "us-east-1b" in zones: zones.remove("us-east-1b");
            return zones
        except Exception as e:
            raise errors.AnsibleError("Could not lookup zones for region: %s\nexception: %s" % (region, e))
