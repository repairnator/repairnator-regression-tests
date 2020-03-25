#!/bin/bash
# run regression tests of repairnator

# with those two options we will catch problems with grep
set -o pipefail
set -e

export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64/

# download the latest version
curl -Lo repairnator-pipeline.jar "https://search.maven.org/remote_content?g=fr.inria.repairnator&a=repairnator-pipeline&v=LATEST&c=jar-with-dependencies"

# each task must take less than 10 minutes otherwise the travis build fails

echo "toy project failingTest NpeFix"
$JAVA_HOME/bin/java -jar repairnator-pipeline.jar --repairTools NPEFix -b 564711868 | tee output.log
grep 'PIPELINE FINDING: PATCHED' output.log

echo "donnelldebnam/CodeU-Spring-2018-29#59 (June 25 2018, NPEFix, merged)"
$JAVA_HOME/bin/java -jar repairnator-pipeline.jar --repairTools NPEFix -b 395891390 | tee output.log
grep 'PIPELINE FINDING: PATCHED' output.log

echo "parkito/BasicDataStructuresAndAlgorithms#3 (Mar 21 2018, merged)"
$JAVA_HOME/bin/java -jar repairnator-pipeline.jar --repairTools NPEFix -b 355923834 | tee output.log
grep 'PIPELINE FINDING: PATCHED' output.log

echo "Defects4J Math70 AstorJGenProg"
$JAVA_HOME/bin/java -jar repairnator-pipeline.jar -b 155069540 --repairTools AstorJGenProg | tee output.log
grep 'PIPELINE FINDING: PATCHED' output.log
