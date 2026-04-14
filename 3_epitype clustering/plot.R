#heatmap
library(ComplexHeatmap)
library(dplyr)
library(pheatmap)

sample_col=read.csv("sample_group.csv", row.names = "sample")
ann_colors = list(
  group = c("Beat AML"="#99d594", "DNMT3A mut"='#f4a582',"DNMT3A wt"= '#92c5de'),
  epitype = c("Epitype 4" = "#354897", "Epitype 5" = "#8f5ea1", "Epitype 6"= "#d88cbc",
              "Epitype 7" = "#f12223", "Epitype 8" = "#f6e815", "Epitype 9" = "#b72027", 
              "Epitype 12" = "#252525", "Epitype 13" = "#cdc7c9",
              "Undefined" = "#eeFfFf")
)

df_valueh=read.csv("valueforheatmap.csv", row.names = "probe", check.names = F)

p_heatmap=pheatmap(as.matrix(df_valueh),annotation_col = sample_col, show_rownames = F,
           clustering_method = "ward.D", na_col = "#DDDDDD", annotation_colors = ann_colors, 
           border_color = "black",color = colorRampPalette(c("#deebf7", "#9ecae1", "#3182bd"))(100)) 


#tSNE plot
library(Rtsne)
df_valuet=read.csv("valuefortsne.csv",check.names = F)
df_valuet_matrix <- as.matrix(df_valuet[,-(1:2)])
df_valuet_matrix_imputed <- apply(df_valuet_matrix, 2, function(x) ifelse(is.na(x), mean(x, na.rm = TRUE), x))

set.seed(4)
tsne_out <- Rtsne(df_value_matrix_imputed,pca=FALSE,perplexity=3,theta=0.0) 
tsne_plot <- data.frame(x = tsne_out$Y[,1], y = tsne_out$Y[,2], col = df_value$sample)
p_tsne=ggplot(tsne_plot) + 
  geom_point(aes(x=x, y=y, color=col))+
  theme_bw()+
  scale_color_manual(values = c("E4" = "#354897", "E5" = "#8f5ea1", "E6"= "#d88cbc",
                                "E7" = "#f12223", "E8" = "#f6e815", "E9" = "#b72027", 
                                "E12" = "#252525", "E13" = "#cdc7c9",
                                "mut1" = "#f4a582","mut2" = "#f4a582","mut3" = "#f4a582","mut4" = "#f4a582",
                                "mut5" = "#f4a582","mut6" = "#f4a582","mut7" = "#f4a582",
                                "wt1"= '#92c5de',"wt2"= '#92c5de',"wt3"= '#92c5de',"wt4"= '#92c5de',
                                "wt5"= '#92c5de',"wt6"= '#92c5de'))+
  geom_text_repel(aes(x=x, y=y,label=col,color=col,size =1))+
  xlab("tSNE1") +  ylab("tSNE2")+ 
  theme(axis.text=element_text(size=12, colour = "black"), 
        axis.title=element_text(size=15, colour = "black"),
        legend.position = 'none',
        legend.title = element_blank(),
        legend.text = element_blank())
p_tsne