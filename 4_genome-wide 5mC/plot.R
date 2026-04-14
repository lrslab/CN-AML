#5mC in 100b bin histogram
dnmt_mtR882_100b=read.csv("100b/dnmt_mtR882_5mc_100b.csv",header=F)
colnames(dnmt_mtR882_100b)=c("bin","cov","ratio")
dnmt_mtR882_100b$type=c("MT")
dnmt_wt_881_100b=read.cs_5mc_100b.csv",header=F)
colnames(dnmt_wt_881_100b)=c("bin","cov","ratio")
dnmt_wt_881_100b$type=c("WT")
dnmt_100b_= rbind(dnmt_mtR882_100b,dnmt_wt_881_100b)
dnmt_100b_$chr=sub("_.*", "", dnmt_100b_$bin)
dnmt_100b_ <- dnmt_100b_[grepl("^[0-9]", dnmt_100b_$bin), ] 
p_100b=ggplot(filter(dnmt_100b_,dnmt_100b_$cov>=100))+
  geom_histogram(aes(x=ratio, fill=factor(type,level=c("WT","MT"))), alpha=0.7,position="identity",bins = 100)+ 
  geom_vline(xintercept=77.35829,color="#f16913", linetype="dashed") +
  geom_vline(xintercept=81.79376,color="#67a9cf", linetype="dashed") +
  scale_fill_manual(values = c("MT"='#f4a582',"WT"='#92c5de'), 
                    labels = c("WT"=expression(DNMT3A^wt),"MT"=expression(DNMT3A^R882mut))) +
  theme_bw()+xlab("5mC% of 100b bin")+ylab("Count")+
  theme(axis.text=element_text(size=15, colour = "black"),
        axis.title=element_text(size=15, colour = "black"),
        legend.position=c(0.43,0.9),
        legend.title = element_blank(),
        legend.text = element_text(size=12))+
  guides(fill=guide_legend(nrow=1))
p_100b

#5mC in 100kb distribution
dnmt_df <- function(file_name, type, upn, id) {
  data <- read.csv(paste0("100k/",file_name), header = FALSE)
  colnames(data) <- c("bin", "ratio")
  data$upn <- upn
  data$type <- type
  data$sample <- paste0(data$type,data$upn)
  data$id <- id
  return(data)
}
file_names <- c("wt1_5mc_hg38_100k.csv","wt2_5mc_hg38_100k.csv","wt3_5mc_hg38_100k.csv",
                "wt4_5mc_hg38_100k.csv","wt5_5mc_hg38_100k.csv","wt6_5mc_hg38_100k.csv",
                "mut1_5mc_hg38_100k.csv","mut2_5mc_hg38_100k.csv","mut3_5mc_hg38_100k.csv",
                "mut4_5mc_hg38_100k.csv","mut6_5mc_hg38_100k.csv","mut6_5mc_hg38_100k.csv")
types <- c("WT","WT","WT","WT","WT","WT","MT","MT","MT","MT", "MT", "MT")
ids <- c("wt1","wt2","wt3","wt4","wt5","wt6",
         "mut1","mut2","mut3","mut4","mut5","mut6")
data_list <- list()
for (i in seq_along(file_names)) {
  data <- dnmt_df(file_names[[i]], types[[i]], upns[[i]], ids[[i]])
    data_list[[i]] <- data
}
dnmt <- do.call(rbind, data_list)
dnmt$chr=sub("_.*", "", dnmt$bin)
dnmt_autos <- dnmt[grepl("^[0-9]", dnmt$bin), ] 
library(see)
p_100k<- ggplot(fdnmt_autos,
                    aes(x=factor(id,level=c("mut6","mut5","mut4","mut3","mut2","mut1",
                                            "wt6","wt5","wt3","wt4","wt2","wt1"))
                        y=ratio*100))+
  geom_violinhalf(outlier.shape=NA,width=2,aes(fill=subtype,color=subtype))+ 
  stat_summary(fun.data=mean_sdl, mult=1, 
               geom="crossbar", width=0.2,color="#666666")+
  theme_bw() + 
  scale_y_continuous(name = "5mC% of 100kb bin", limits = c(0, 105), breaks = seq(0, 105, 25)) + 
  scale_color_manual(values = c("MT"='#f4a582',"WT"='#92c5de')) +
  scale_fill_manual(values = c("MT"='#f4a582',"WT"='#92c5de')) +
  xlab("") + theme(axis.text=element_text(size=15, colour = "black"), 
                   axis.title=element_text(size=15, colour = "black"),
                   legend.position = "none")+
  guides(color = guide_legend(nrow = 1))+
  coord_flip()
p_100k