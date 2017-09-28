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
CODING_BED=$4
CODING_BED_MT=$5
GATK_KEY=$6

IN_PROJECT=$7
PREFIX=$8
OUT_PROJECT=$9
SM_TAG=${10}
REF_GENOME=${11}

# Filter snv only, REMOVE NON-VARIANT, FAIL, CODING

START_EXTRACT_CODING_PASS_VARIANT_SNV=`date '+%s'`

$JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
-T SelectVariants \
-R $REF_GENOME \
-sn $SM_TAG \
-ef \
-env \
--keepOriginalAC \
-selectType SNP \
-L $CODING_BED \
-L $CODING_BED_MT \
-et NO_ET \
-K $GATK_KEY \
--variant $CORE_PATH/$IN_PROJECT/MULTI_SAMPLE/$PREFIX".BEDsuperset.VQSR.1KG.ExAC3.REFINED.vcf.gz" \
-o $CORE_PATH/$OUT_PROJECT/SNV/MULTI/CODING/PASS_VARIANT/$SM_TAG".CODING.SNV.VARIANT.PASS.vcf.gz"

END_EXTRACT_CODING_PASS_VARIANT_SNV=`date '+%s'`

HOSTNAME=`hostname`

echo $SM_TAG"_"$IN_PROJECT",J.01,EXTRACT_CODING_PASS_VARIANT_SNV,"$HOSTNAME","$START_EXTRACT_CODING_PASS_VARIANT_SNV","$END_EXTRACT_CODING_PASS_VARIANT_SNV \
>> $CORE_PATH/$IN_PROJECT/REPORTS/$IN_PROJECT".WALL.CLOCK.TIMES.csv"

echo $JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
-T SelectVariants \
-R $REF_GENOME \
-sn $SM_TAG \
-ef \
-env \
--keepOriginalAC \
-selectType SNP \
-L $CODING_BED \
-L $CODING_BED_MT \
-et NO_ET \
-K $GATK_KEY \
--variant $CORE_PATH/$IN_PROJECT/MULTI_SAMPLE/$PREFIX".BEDsuperset.VQSR.1KG.ExAC3.REFINED.vcf.gz" \
-o $CORE_PATH/$OUT_PROJECT/SNV/MULTI/CODING/PASS_VARIANT/$SM_TAG".CODING.SNV.VARIANT.PASS.vcf.gz" \
>> $CORE_PATH/$IN_PROJECT/COMMAND_LINES/$SM_TAG".COMMAND_LINES.txt"

echo >> $CORE_PATH/$IN_PROJECT/COMMAND_LINES/$SM_TAG".COMMAND_LINES.txt"
