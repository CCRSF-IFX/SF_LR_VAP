from snakemake.utils import validate
import pandas as pd

##### load config and sample sheets #####

configfile: "config/config.yaml"
validate(config, schema="../schemas/config.schema.yaml")

samplepd = pd.read_csv(config["samples"], sep="\t").set_index("sample", drop=False)
samplepd.index.names = ["sample_id"]
#validate(samplepd, schema="../schemas/samples.schema.yaml")

analysis = config.analysispath
samples = samplepd["filename"].to_list()
