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
DBSNP_129=$4
GATK_KEY=$5

IN_PROJECT=$6
OUT_PROJECT=$7
SM_TAG=$8
REF_GENOME=$9

# PASSING SNVS IN CODING REGIONS THAT ARE NOT IN DBSNP 129

START_EXTRACT_CODING_NOVEL

$JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
-T SelectVariants \
-R $REF_GENOME \
-et NO_ET \
-K $GATK_KEY \
--variant $CORE_PATH/$OUT_PROJECT/SNV/MULTI/CODING/PASS_VARIANT/$SM_TAG".CODING.SNV.VARIANT.PASS.vcf.gz" \
--discordance $DBSNP_129 \
-o $CORE_PATH/$OUT_PROJECT/TEMP/$SM_TAG".QC.Coding.Novel.TiTv.vcf"

END_EXTRACT_CODING_NOVEL=`date '+%s'`

HOSTNAME=`hostname`

echo $SM_TAG"_"$IN_PROJECT",K.01,EXTRACT_CODING_NOVEL,"$HOSTNAME","$START_EXTRACT_CODING_NOVEL","$END_EXTRACT_CODING_NOVEL \
>> $CORE_PATH/$IN_PROJECT/REPORTS/$IN_PROJECT".WALL.CLOCK.TIMES.csv"

echo $JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
-T SelectVariants \
-R $REF_GENOME \
-et NO_ET \
-K $GATK_KEY \
--variant $CORE_PATH/$OUT_PROJECT/SNV/MULTI/CODING/PASS_VARIANT/$SM_TAG".CODING.SNV.VARIANT.PASS.vcf.gz" \
--discordance $DBSNP_129 \
-o $CORE_PATH/$OUT_PROJECT/TEMP/$SM_TAG".QC.Coding.Novel.TiTv.vcf" \
>> $CORE_PATH/$IN_PROJECT/COMMAND_LINES/$SM_TAG".COMMAND_LINES.txt"

echo >> $CORE_PATH/$IN_PROJECT/COMMAND_LINES/$SM_TAG".COMMAND_LINES.txt"
