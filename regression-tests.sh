#!/bin/bash
# run regression tests of repairnator

# with those two options we will catch problems with grep
set -o pipefail
set -e

export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64/

export M2_HOME=/usr/local/maven-3.6.3

# download the latest version
curl -Lo repairnator-pipeline.jar "https://search.maven.org/remote_content?g=fr.inria.repairnator&a=repairnator-pipeline&v=LATEST&c=jar-with-dependencies"

# each task must take less than 10 minutes otherwise the travis build fails

echo "toy project failingTest NpeFix"
time $JAVA_HOME/bin/java -jar repairnator-pipeline.jar --ghOauth $GITHUB_TOKEN --repairTools NPEFix -b 564711868 | tee output.log
grep 'PIPELINE FINDING: PATCHED' output.log

echo "donnelldebnam/CodeU-Spring-2018-29#59 (June 25 2018, NPEFix, merged)"
time $JAVA_HOME/bin/java -jar repairnator-pipeline.jar --ghOauth $GITHUB_TOKEN --repairTools NPEFix -b 395891390 | tee output.log
grep 'PIPELINE FINDING: PATCHED' output.log

echo "parkito/BasicDataStructuresAndAlgorithms#3 (Mar 21 2018, merged)"
time $JAVA_HOME/bin/java -jar repairnator-pipeline.jar --ghOauth $GITHUB_TOKEN --repairTools NPEFix -b 355923834 | tee output.log
grep 'PIPELINE FINDING: PATCHED' output.log

###############  NOPOL #####################
# now we test Nopol

# reproducing https://github.com/Spirals-Team/open-science-repairnator/blob/master/data/expedition-2/374841318.html (a Kali patch)
$JAVA_HOME/bin/java -cp $JAVA_HOME/lib/tools.jar:repairnator-pipeline.jar fr.inria.spirals.repairnator.pipeline.Launcher --ghOauth $GITHUB_TOKEN --repairTools NopolAllTests -b 374841318 | tee output.log
grep 'PIPELINE FINDING: PATCHED' output.log



## does not work, bug in Astor?
# echo "Defects4J Math70 AstorJGenProg (from paper)"
# $JAVA_HOME/bin/java -jar repairnator-pipeline.jar--ghOauth $GITHUB_TOKEN  --repairTools AstorJGenProg -b 155069540  | tee output.log
# grep 'PIPELINE FINDING: PATCHED' output.log

