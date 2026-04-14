library(ggplot2)
library(dplyr)
library(see)

#5mC in 100b bin histogram
mtR882_100b=read.csv("100b/mtR882_5mc_100b.csv",header=F)
colnames(mtR882_100b)=c("bin","cov","ratio")
mtR882_100b$type=c("MT")
wt_100b=read.csv("100b/wt_5mc_100b.csv",header=F)
colnames(wt_881_100b)=c("bin","cov","ratio")
wt_881_100b$type=c("WT")
bind_100b= rbind(mtR882_100b,wt_100b)
bind_100b$chr=sub("_.*", "", bind_00b_$bin)
bind_100b<- bind_100b[grepl("^[0-9]", bind_100b_$bin), ] 
p_100b=ggplot(filter(bind_100b,bind_100b$cov>=100))+
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
df_100k <- function(file_name, type, upn, id) {
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
  data <- df_100k(file_names[[i]], types[[i]], upns[[i]], ids[[i]])
    data_list[[i]] <- data
}
df_100k_bind <- do.call(rbind, data_list)
df_100k_bind$chr=sub("_.*", "", df_100k_bind$bin)
df_100k_bind_autos <- df_100k_bind[grepl("^[0-9]", df_100k_bind$bin), ] 

p_100k<- ggplot(df_100k_bind_autos,
                    aes(x=factor(id,level=c("mut6","mut5","mut4","mut3","mut2","mut1",
                                            "wt6","wt5","wt3","wt4","wt2","wt1")),
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