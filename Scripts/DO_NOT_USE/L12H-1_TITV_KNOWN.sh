#$ -S /bin/bash
#$ -q rnd.q,prod.q,test.q
#$ -cwd
#$ -p -1000
#$ -V

SAMTOOLS_DIR=$1

CORE_PATH=$2
PROJECT=$3
SM_TAG=$4

CMD=$SAMTOOLS_DIR'/bcftools/vcfutils.pl qstats '$CORE_PATH'/'$PROJECT'/TEMP/'$SM_TAG'.Release.Known.TiTv.vcf'
CMD=$CMD' >| '$CORE_PATH'/'$PROJECT'/REPORTS/TI_TV_MS/'$SM_TAG'_Known_.titv.txt'

echo $CMD >> $CORE_PATH/$PROJECT/command_lines.txt
echo >> $CORE_PATH/$PROJECT/command_lines.txt
echo $CMD | bash
