X       76707750        .       G       A       31101.25        .       ABHet=0.491;ABHom=1.00;AC=63;AF=0.332;AN=190;BaseQRankSum=3.28;DP=2439;FS=1.848;MLEAC=63;MLEAF=0.332;MQ=60.00;MQ0=0;MQRankSum=-
4.270e-01;NDA=1;QD=23.69;ReadPosRankSum=0.292;SOR=0.580 GT:AD:DP:GQ:PL  1/1:0,25:.:75:1002,75,0

1       10583   .       G       A       5730.08 .       ABHet=0.674;ABHom=0.932;AC=48;AF=0.253;AN=190;BaseQRankSum=-8.680e-01;DP=1959;MLEAC=60;MLEAF=0.316;MQ=50.49;MQ0=0;MQRankSum=-1.580e-01;NDA=1;ON
D=2.234e-03;ReadPosRankSum=-3.650e-01;SOR=0.837 GT:AD:DP:GQ:PGT:PID:PL  0/1:18,4:.:61:0|1:10583_G_A:61,0,628

FS=1.848
QD=23.69

/isilon/sequencing/CIDRSeqSuiteSoftware/java/jre1.7.0_45/bin/java -jar \
/isilon/sequencing/CIDRSeqSuiteSoftware/gatk/GATK_3/GenomeAnalysisTK-3.3-0//GenomeAnalysisTK.jar \
-T HaplotypeCaller \
-R /isilon/sequencing/GATK_resource_bundle/bwa_mem_0.7.5a_ref/human_g1k_v37_decoy.fasta \
--input_file /isilon/sequencing/Seq_Proj/M_Valle_MendelianDisorders_SeqWholeExome_120511_64/BAM/AGGREGATE/85909-0209702557.bam \
-L /isilon/sequencing/Seq_Proj/M_Valle_MendelianDisorders_SeqWholeExome_120511_64/BED_Files/Baits_BED_File_Agilent_51Mb_v4_S03723314_ALL_Merged_111912_NOCHR.bed \
--emitRefConfidence GVCF \
--variant_index_type LINEAR \
--variant_index_parameter 128000 \
-A DepthPerSampleHC \
-A ClippingRankSumTest \
-A MappingQualityRankSumTest \
-A ReadPosRankSumTest \
-A FisherStrand \
-A GCContent \
-A AlleleBalanceBySample \
-A AlleleBalance \
-A QualByDepth \
-pairHMM VECTOR_LOGLESS_CACHING \
-o /isilon/sequencing/Seq_Proj/M_Valle_MendelianDisorders_SeqWholeExome_120511_64/GVCF/85909-0209702557.genome.vcf

$JAVA_1_7/java -jar $GATK_DIR/GenomeAnalysisTK.jar \
-T HaplotypeCaller \
-R $REF_GENOME \
--input_file $CORE_PATH/$PROJECT/BAM/$SM_TAG".bam" \
-L $CHROMOSOME \
--emitRefConfidence GVCF \
--variant_index_type LINEAR \
--variant_index_parameter 128000 \
--standard_min_confidence_threshold_for_calling 30 \
--standard_min_confidence_threshold_for_emitting 10 \
--max_alternate_alleles 3 \
-pairHMM VECTOR_LOGLESS_CACHING \
--annotation AlleleBalance \
--annotation Coverage \
--annotation MappingQualityZero \
-o $CORE_PATH/$PROJECT/TEMP/$SM_TAG"."$CHROMOSOME".g.vcf"