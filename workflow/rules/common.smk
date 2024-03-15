from snakemake.utils import validate
import pandas as pd

##### load config and sample sheets #####

configfile: "config/config.yaml"
validate(config, schema="../schemas/config.schema.yaml")

def load_samples(samplesheet):
    samples = {}
    with open(samplesheet, 'r') as f:
        for line in f:
            sample, path = line.strip().split(',')
            samples[sample] = {'path': path}
    return samples

samples = load_samples(config["sample_sheet"])

analysis = config.analysispath
