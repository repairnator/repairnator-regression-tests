#!/bin/bash
# run regression tests of repairnator

set -e

# download the latest version
curl -Lo repairnator-pipeline.jar "https://search.maven.org/remote_content?g=fr.inria.repairnator&a=repairnator-pipeline&v=LATEST&c=jar-with-dependencies"

# 01 failing test
java -jar repairnator-pipeline.jar -b 564711868
ls
