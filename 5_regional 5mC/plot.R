#average 5mc proportion in CpG island and flanking regions 
library(ggplot2)
library(dplyr)
library(ggh4x)

df_cpgi_avg=read.csv("cpgi/cpgi_region_average.csv")
strip_colors <- c("CpG Island"="#009E73","CpG Shore"="#56B4E9","CpG Shelf"="#0072B2")
text_df_cpgissavg <- data.frame(
  cpg_region = c("CpG Island", "CpG Shore", "CpG Shelf"),
  x = c(1.5,1.5,1.5),
  y = c(80, 30, 30),
  label = c("P=0.0079", "P=0.0210", "P=0.0414")
)
p_cpgi_avg=ggplot(data=df_cpgi_avg,
                         aes(x=factor(type,level=c("WT",'MT')),y=avg_ratio*100,fill=type))+
  geom_boxplot()+
   scale_fill_manual(values = c("MT"='#f4a582',"WT"='#92c5de'))+
  scale_x_discrete(labels=c("WT"='wt', "MT"='R882mut'))+
  xlab("") + ylab("Mean 5mC%")+ 
  ylim(30,85)+
  geom_text(data = text_df_cpgissavg, aes(x = x, y = y, label = label), inherit.aes = F, size=5) +
  ggh4x::facet_wrap2(~cpg_region, strip = ggh4x::strip_themed(
    background_x = ggh4x::elem_list_rect(fill = strip_colors)
  )) +
    theme_bw()+
  theme(axis.text=element_text(size=15, colour = "black"), 
        axis.title=element_text(size=15, colour = "black"),
        legend.position = "none",
        strip.text = element_text(size = 12))
p_cpgi_avg