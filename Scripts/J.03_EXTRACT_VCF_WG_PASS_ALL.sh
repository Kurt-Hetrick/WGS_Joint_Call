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

JAVA_1_7=$1
GATK_DIR=$2
CORE_PATH=$3
GATK_KEY=$4

IN_PROJECT=$5
PREFIX=$6
OUT_PROJECT=$7
SM_TAG=$8
REF_GENOME=$9

# Extract out sample, REMOVE NON-VARIANT, FILTERED

START_EXTRACT_WG_PASS_ALL=`date '+%s'`

$JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
-T SelectVariants \
-R $REF_GENOME \
--keepOriginalAC \
-sn $SM_TAG \
-ef \
-et NO_ET \
-K $GATK_KEY \
--variant $CORE_PATH/$IN_PROJECT/MULTI_SAMPLE/$PREFIX".BEDsuperset.VQSR.1KG.ExAC3.REFINED.vcf.gz" \
-o $CORE_PATH/$OUT_PROJECT/VCF/MULTI/WHOLE_GENOME/PASS_ALL/$SM_TAG".WHOLE.GENOME.ALL.PASS.vcf.gz"

END_EXTRACT_WG_PASS_ALL=`date '+%s'`

HOSTNAME=`hostname`

echo $SM_TAG"_"$IN_PROJECT",J.01,EXTRACT_WG_PASS_ALL,"$HOSTNAME","$START_EXTRACT_WG_PASS_ALL","$END_EXTRACT_WG_PASS_ALL \
>> $CORE_PATH/IN_PROJECT/REPORTS/$IN_PROJECT".WALL.CLOCK.TIMES.csv"

$JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
-T SelectVariants \
-R $REF_GENOME \
--keepOriginalAC \
-sn $SM_TAG \
-ef \
-et NO_ET \
-K $GATK_KEY \
--variant $CORE_PATH/$OUT_PROJECT/VCF/MULTI/WHOLE_GENOME/PASS_ALL/$SM_TAG".WHOLE.GENOME.ALL.PASS.vcf.gz" \
-o $CORE_PATH/$OUT_PROJECT/VCF/MULTI/WHOLE_GENOME/PASS_ALL/$SM_TAG".WHOLE.GENOME.PASS.ALL.vcf.gz"

echo >> $CORE_PATH/$IN_PROJECT/COMMAND_LINES/$SM_TAG".COMMAND_LINES.txt"
