print ("This file was created within RStudio")
print("And now it lives on GitHub")

#Datos para determinar el Minimal Detectable Flux - f. detect - app Dr. Hüppi
#para cinco minutos riego 1 y 2 
# tiempo: 0; 0.006; 0.012; 0.018; 0.024; 0.030; 0.036; 0.042; 0.048; 0.054; 0.060; 0.066; 0.072; 0.078; 0.084; 0.090; 0.096; 0.102; 0.108; 0.114; 0.120; 0.126; 0.132; 0.138; 0.144; 0.150; 0.156; 0.162; 0.168 
# cámara: área cámara (m2): 0.169646
# volumen cámara (m3): 0.05340072
#  desv. estándar CH4: 122.06 (ppb)
# opción: No lineal
# resultado app: 
# [1] "Estimated minimal detectable flux:"
# 97.5% 
#2.242647 
# [1] "[mg CH4/m^2/h ]"
# [1] "Number of HMR fluxes detected:"
# [1] 28

# Análisis gasfluxes: 
library("gasfluxes")

fluxMeas_CH4_riego3y4 <- read_excel("Data/BaseR_CH4/BaseR_CH4COM_10min_riego3y4.xlsx")

gasfluxes(fluxMeas_CH4_riego3y4, .id = "serie", .V = "V", .A = "A", .times = "time",.C = "C", methods = c("linear", "robust linear", "HMR", "NDFE"),k_HMR = log(1.5), k_NDFE = log(0.01),verbose = FALSE, plot = FALSE)
f.detect2 <- 2.242647  

t.meas2 <- max(fluxMeas_CH4_riego3y4$time)
# resultado t.meas: 0.168611111061182

resCH4_10 <- gasfluxes(fluxMeas_CH4_riego3y4,.id = "serie", .V = "V", .A = "A",.times = "time", .C = "C",methods = c("linear", "robust linear", "HMR"), verbose = FALSE, plot = FALSE)
selectfluxes(resCH4_10, "kappa.max", f.detect = f.detect2, t.meas = t.meas2)
write.table(resCH4_10, file="Res_CH4_10min_Riego3y4_18oct.csv", row.names = FALSE, sep = " , ")
