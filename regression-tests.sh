#!/bin/bash
# run regression tests of repairnator

# with those two options we will catch problems with grep
set -o pipefail
set -e

export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64/

# download the latest version
curl -Lo repairnator-pipeline.jar "https://search.maven.org/remote_content?g=fr.inria.repairnator&a=repairnator-pipeline&v=LATEST&c=jar-with-dependencies"

# toy project failingTest NpeFix
java -jar repairnator-pipeline.jar --repairTools NPEFix -b 564711868 | grep 'PIPELINE FINDING: PATCHED'

# donnelldebnam/CodeU-Spring-2018-29#59 (June 25 2018, NPEFix, merged)
java -jar repairnator-pipeline.jar --repairTools NPEFix -b 395891390 | grep 'PIPELINE FINDING: PATCHED'

# parkito/BasicDataStructuresAndAlgorithms#3 (Mar 21 2018, merged)
java -jar repairnator-pipeline.jar --repairTools NPEFix -b 355923834 | grep 'PIPELINE FINDING: PATCHED'

