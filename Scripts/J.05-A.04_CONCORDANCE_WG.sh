# ---qsub parameter settings---
# --these can be overrode at qsub invocation--

# tell sge to execute in bash
#$ -S /bin/bash

# tell sge to submit any of these queue when available
#$ -q rnd.q,prod.q,test.q,bigdata.q

# tell sge that you are in the users current working directory
#$ -cwd

# tell sge to export the users environment variables
#$ -V

# tell sge to submit at this priority setting
#$ -p -1020

# tell sge to output both stderr and stdout to the same file
#$ -j y

# export all variables, useful to find out what compute node the program was executed on
# redirecting stderr/stdout to file as a log.

set

echo

JAVA_CIDRSEQSUITE=$1
CIDRSEQSUITE_6_1_1=$2
CORE_PATH=$3
NO_GAP_BED=$4
VERACODE=$5

IN_PROJECT=$6
OUT_PROJECT=$7
SM_TAG=$8

# CONCORDANCE

START_CONCORDANCE=`date '+%s'`

# Do concordance on whole genome

# Make a temporary directory for the whole genome pass snvs

mkdir -p $CORE_PATH/$OUT_PROJECT/TEMP/$SM_TAG

# decompress the whole genome pass snv into the temp directory make above

zcat $CORE_PATH/$OUT_PROJECT/SNV/MULTI/WHOLE_GENOME/PASS_VARIANT/$SM_TAG".WHOLE.GENOME.SNV.VARIANT.PASS.vcf.gz" \
>| $CORE_PATH/$OUT_PROJECT/TEMP/$SM_TAG/$SM_TAG".WHOLE.GENOME.SNV.VARIANT.PASS.vcf.gz"

# Run cidrseqsuite

START_CONCORDANCE=`date '+%s'`

$JAVA_CIDRSEQSUITE/java -jar \
$CIDRSEQSUITE_6_1_1/CIDRSeqSuite.jar \
-pipeline -concordance \
$CORE_PATH/$OUT_PROJECT/TEMP/$SM_TAG \
$CORE_PATH/$OUT_PROJECT/Pretesting/Final_Genotyping_Reports/ \
$CORE_PATH/$OUT_PROJECT/TEMP/$SM_TAG \
$NO_GAP_BED \
$VERACODE

END_CONCORDANCE=`date '+%s'`

HOSTNAME=`hostname`

echo $SM_TAG"_"$IN_PROJECT",L.01,CONCORDANCE,"$HOSTNAME","$START_CONCORDANCE","$END_CONCORDANCE \
>> $CORE_PATH/$IN_PROJECT/REPORTS/$IN_PROJECT".WALL.CLOCK.TIMES.csv"

echo $JAVA_CIDRSEQSUITE/java -jar \
$CIDRSEQSUITE_6_1_1/CIDRSeqSuite.jar \
-pipeline -concordance \
$CORE_PATH/$OUT_PROJECT/TEMP/$SM_TAG \
$CORE_PATH/$OUT_PROJECT/Pretesting/Final_Genotyping_Reports/ \
$CORE_PATH/$OUT_PROJECT/TEMP/$SM_TAG \
$NO_GAP_BED \
$VERACODE \
>> $CORE_PATH/$IN_PROJECT/COMMAND_LINES/$SM_TAG".COMMAND_LINES.txt"

echo >> $CORE_PATH/$IN_PROJECT/COMMAND_LINES/$SM_TAG".COMMAND_LINES.txt"

mv $CORE_PATH/$OUT_PROJECT/TEMP/$SM_TAG/$SM_TAG"_concordance.csv" \
$CORE_PATH/$OUT_PROJECT/REPORTS/CONCORDANCE/$SM_TAG"_concordance.csv"

mv $CORE_PATH/$OUT_PROJECT/TEMP/$SM_TAG/missing_data.csv \
$CORE_PATH/$OUT_PROJECT/REPORTS/CONCORDANCE/$SM_TAG"_missing_data.csv"

mv $CORE_PATH/$OUT_PROJECT/TEMP/$SM_TAG/discordant_data.csv \
$CORE_PATH/$OUT_PROJECT/REPORTS/CONCORDANCE/$SM_TAG"_discordant_calls.csv"
