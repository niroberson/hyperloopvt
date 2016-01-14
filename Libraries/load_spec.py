import json
import os


def load_spec(spec_name):
    # Get directory of specs
    base = os.getcwd()
    spec_filename = spec_name + '.json'
    spec_path = os.path.join(base, '..', 'Specs', spec_filename)
    # Json load
    json_data=open(spec_path).read()
    return json.loads(json_data)