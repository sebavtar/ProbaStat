library(dplyr)

data <- read.csv("Success_ProbaStat.csv")

########### Solution R: ##########

Prop <- data %>% count(Section, Succes) %>% mutate(prop = prop.table(n))
Prop

########### Solution R: ##########

# Probabilité empirique d'être en GM ou en EL
prop_section <- data %>% count(Section) %>% mutate(prop = prop.table(n))
# Probabilité empirique de réussir l'examen en fonction de la section GM ou en EL
prop_succes <- Prop %>% filter(Succes == 1) %>% select(Section,prop)
# Probabilité empirique de ne pas réussir l'examen en fonction de la section GM ou en EL
prop_fail <- Prop %>% filter(Succes == 0) %>% select(Section,prop)

# Calcul de cette somme de probabilité
prob_sum <- prop_succes[1,2]/prop_section[1,3] + prop_succes[2,2]/prop_section[2,3]
prob_sum

########### Solution R: ##########

EL <- prop_succes[1,2]/prop_section[1,3] + prop_fail[1,2]/prop_section[1,3]
GM <- prop_succes[2,2]/prop_section[2,3] + prop_fail[2,2]/prop_section[2,3]

EL
GM

source("fonction.r")

X = c(0,1,2,3,4,5,6,7,8,9,10)

# Vous pouvez accéder à ces quatres fonctions, f1,f2,f3,f4, de la manière suivante
f1(2)

########### Solution R: ##########

# Vérifier si f1 est une fonction de masse
masse <- TRUE
sum_ <- 0
for (x in X){
    sum_ <- sum_ + f1(x)
    if (f1(x)<0){
        masse = FALSE
        sprintf("f1(%i) = %f < 0", x,f1(x))
    }
}

if (abs(sum_-1)>1e-06){
    masse = FALSE
}

if (masse){
    print("La fonction f1 est donc une fonction de masse")
} else{
    print("La fonction f1 n'est donc pas une fonction de masse")
}

########### Solution R: ##########

# Vérifier si f2 est une fonction de masse
masse <- TRUE
sum_ <- 0
for (x in X){
    sum_ <- sum_ + f2(x)
    if (f2(x)<0){
        masse = FALSE
        sprintf("f2(%i) = %f < 0", x,f2(x))
    }
}

if (abs(sum_-1)>1e-06){
    masse = FALSE
}

if (masse){
    print("La fonction f2 est donc une fonction de masse")
} else{
    print("La fonction f2 n'est donc pas une fonction de masse")
}

########### Solution R: ##########

# Vérifier si f2 est une fonction de masse
masse <- TRUE
sum_ <- 0
for (x in X){
    sum_ <- sum_ + f3(x)
    if (f3(x)<0){
        masse = FALSE
        sprintf("f3(%i) = %f < 0", x,f3(x))
    }
}

if (abs(sum_-1)>1e-06){
    masse = FALSE
}

if (masse){
    print("La fonction f3 est donc une fonction de masse")
} else{
    print("La fonction f3 n'est donc pas une fonction de masse")
}

########### Solution R: ##########

# Vérifier si f4 est une fonction de masse
masse <- TRUE
sum_ <- 0
for (x in X){
    sum_ <- sum_ + f4(x)
    if (f4(x)<0){
        masse = FALSE
        sprintf("f4(%i) = %f < 0", x,f4(x))
    }
}

if (abs(sum_-1)>1e-06){
    masse = FALSE
}

if (masse){
    print("La fonction f4 est donc une fonction de masse")
} else{
    print("La fonction f4 n'est donc pas une fonction de masse")
}

library(ggplot2)
library(patchwork)

data1 <- data.frame(x=c(-10.,0.,0.,10.,10.,20.,20.,30.,30.,40.,40.,50.,50.,60.,60.,70.,70.,80.,80.,90.,90.,100.,100.,120.,120.),
            y=c(0.,0.,0.1,0.1,0.19,0.19,0.25,0.25,0.34,0.34,0.45,0.45,0.5,0.5,0.57,0.57,0.61,0.61,0.63,0.63,0.65,0.65,0.67,0.67,0.67))
data2 <- data.frame(x=0.1*c(-10.,0.,0.,10.,10.,20.,20.,30.,30.,35.,35.,50.,50.,54.,54.,70.,70.,83.,83.,90.,90.,115.,115.,120.,120.),
                    y=c(0.,0.,0.05,0.05,0.09,0.09,0.15,0.15,0.34,0.34,0.39,0.39,0.47,0.47,0.67,0.67,0.86,0.86,0.89,0.89,0.91,0.91,1.,1.,1.))
data3 <- data.frame(x=c(-10.,0.,0.,10.,10.,20.,20.,30.,30.,35.,35.,50.,50.,54.,54.,70.,70.,83.,83.,90.,90.,115.,115.,120.,120.),
                   y=c(0.,0.,0.05,0.05,0.09,0.09,0.15,0.15,0.34,0.34,0.39,0.39,0.47,0.47,0.67,0.67,0.86,0.86,0.84,0.84,0.91,0.91,1.,1.,1.))

f1 <- ggplot(data1,aes(x,y)) + geom_line() + labs(title = "Figure 1") + theme(plot.title = element_text(hjust = 0.5))
f2 <- ggplot(data2,aes(x,y)) + geom_line() + labs(title = "Figure 2") + theme(plot.title = element_text(hjust = 0.5))
f3 <- ggplot(data3,aes(x,y)) + geom_line() + labs(title = "Figure 3") + theme(plot.title = element_text(hjust = 0.5))

(f1 + f2) / f3 

bern <- function(p,n){
    # Générer une variable aléatoire de Bernouilli avec probabilité de succès p
    
    X <- 1*(runif(n) < p)
    X
}

library(ggplot2)

n <- 10000
p <- 0.3

# Générer n variable de Bernoulli avec probabilité de succès p
df <- data.frame(X = bern(p,n))

# Calcul de la moyenne empirique 
mean <- mean(df$X)
sprintf("La moyenne de la variable générée est %f",mean)

# Plot pour vérifier expérimentalement que la fonction bern génère bien des variables de Bernoulli
df$cumulative_prop <- cumsum(df$X)/(1:n)
df$iter <- 1:n

fig <-ggplot(df,aes(x=iter,y=cumulative_prop)) + geom_line() + 
    labs(title="Plot de la proportion de succès pour un nombre\n croissant de varibales générées", 
         x = 'Nombre de variable générée',y="Proportion de succès") +
    theme(plot.title = element_text(hjust = 0.5, size = 16))
fig

geom <- function(p){
    if (p<1e-06){
        stop("La probabilité de succès doit être supérieure à zéro.")
    }
    
    
    S <- 1
    X <- bern(p,1)
    
    while (X != 1){
        S <- S + 1
        X <- bern(p,1)
    }
    S
    
}

n <- 10000
p <- 0.3

# Générer n observations de S
df <- data.frame(S = sapply(p*rep(1,n), FUN = geom))

# Proposer une estimation de P(S = 1)
prob1 <- sum(df$S == rep(1,n))/n
sprintf("On estime donc cette probabilité par : %f",prob1)

# Faire un plot montrant la convergence de cette probabilité
df$prob <- cumsum((df$S == rep(1,n)))/(1:n)
df$iter <- 1:n

fig <-ggplot(df,aes(x=iter,y=prob)) + geom_line() + 
    labs(title="Convergence de l'estimation de P(S=1)", 
         x = 'Nombre de variable générée',y="Estimation de la probabilité") +
    theme(plot.title = element_text(hjust = 0.5, size = 16))
fig

n <- 10000
p <- 0.3

# Générer n observations de S
df <- data.frame(S = sapply(p*rep(1,n), FUN = geom))

# Proposer une estimation de P(S = 1)
prob2 <- sum(df$S > 3.*rep(1,n))/n
sprintf("On estime donc cette probabilité par : %f",prob2)

# Faire un plot montrant la convergence de cette probabilité
df$prob <- cumsum((df$S > 3*rep(1,n)))/(1:n)
df$iter <- 1:n

fig <-ggplot(df,aes(x=iter,y=prob)) + geom_line() + 
    labs(title="Convergence de l'estimation de P(S>1)", 
         x = 'Nombre de variable générée',y="Estimation de la probabilité") +
    theme(plot.title = element_text(hjust = 0.5, size = 16))
fig

n <- 20000
p <- 0.3

t <- 4
m <- 2

# Générer deux ensemble de n observations de S pour estimer chacunes de ces 
# deux probabilités avec deux ensembles distinct
df <- data.frame(S1 = sapply(p*rep(1,n), FUN = geom),S2 = sapply(p*rep(1,n), FUN = geom))

# Proposer une estimation de P(S > t + m | S > t)
prob3_1 <- sum(df$S1 > (t+m)*rep(1,n))/n
prob3_2 <- sum(df$S2 > t*rep(1,n))/n
prob3 <- prob3_1/prob3_2
sprintf("On estime donc la probabilité P(S > t + m | S > t) par : %f",prob3)

# Proposer une estimation de P(S > m)
prob3_ <- sum(df$S2 > m*rep(1,n))/n
sprintf("On estime donc la probabilité P(S > m) par : %f",prob3_)

# Faire un plot montrant la convergence de cette probabilité
p_sup_t <- cumsum((df$S1 > t*rep(1,n)))
ind <- (p_sup_t > 0)

df_ <- data.frame(iter = (1:n)[ind], 
                 diff = abs(cumsum((df$S1 > (t+m)*rep(1,n)))[ind]/cumsum((df$S1 > t*rep(1,n)))[ind]-cumsum((df$S2 > m*rep(1,n)))[ind]/(1:n)[ind]))

fig <-ggplot(df_,aes(x=iter,y=diff)) + geom_line() + 
    labs(title="Convergence de la différence entre les deux estimations", 
         x = 'Nombre de variable générée',y="Différence absolue en les deux estimations") +
    theme(plot.title = element_text(hjust = 0.5, size = 16))
fig

library(ggplot2)
library(patchwork)

data1 <- data.frame(x=c(-1.,0.,0.,1.,1.,2.),
                    y=c(0.,0.,2.,2.,0.,0.))
data2 <- data.frame(x=c(-1.,0.25,0.25,0.75,0.75,2.),
                    y=c(0.,0.,1.,1.,0.,0.))
data3 <- data.frame(x=c(-1.,0.,0.,1.,1.,2.),
                    y=c(0.,0.,1.,1.,0.,0.))
data4 <- data.frame(x=c(-1.,-0.5,0.,0.5,1.,1.5,2.,2.5),
                    y=c(0.,0.,1.,0.,0.,1.,0.,0.))

f1 <- ggplot(data1,aes(x,y)) + geom_line() + labs(title = "Figure 1") + theme(plot.title = element_text(hjust = 0.5))
f2 <- ggplot(data2,aes(x,y)) + geom_line() + labs(title = "Figure 2") + theme(plot.title = element_text(hjust = 0.5))
f3 <- ggplot(data3,aes(x,y)) + geom_line() + labs(title = "Figure 3") + theme(plot.title = element_text(hjust = 0.5))
f4 <- ggplot(data4,aes(x,y)) + geom_line() + labs(title = "Figure 4") + theme(plot.title = element_text(hjust = 0.5))
(f1 + f2) / (f3 + f4) 

library(ggplot2)
library(patchwork)

data1 <- data.frame(x=c(-10.,0.,0.,10.,10.,20.,20.,30.,30.,40.,40.,50.,50.,60.,60.,70.,70.,80.,80.,90.,90.,100.,100.,120.,120.),
                    y=c(0.,0.,0.1,0.1,0.19,0.19,0.25,0.25,0.34,0.34,0.45,0.45,0.5,0.5,0.57,0.57,0.61,0.61,0.63,0.63,0.65,0.65,0.67,0.67,0.67))/0.67
data2 <- data.frame(x=seq(-10, 10, length.out = 100),
                    y=exp(seq(-10, 10, length.out = 100))/(1+exp(seq(-10, 10, length.out = 100))))
data3 <- data.frame(x=c(-1.,0.,1.,2.),
                    y=c(0.,0.,1.,1.))
data4 <- data.frame(x=c(-1.,0,1,2,2,3,4),
                    y=c(0.,0.,0.4,0.4,0.6,1.,1))
data5 <- data.frame(x=c(-1.,0,1,2,2,3,4),
                    y=c(0.,0.,0.4,0.,0.6,1.,1))
data6 <- data.frame(x=c(-1.,0,0,1,1,2),
                    y=c(0.,0.,0.4,0.4,1.,1))

f1 <- ggplot(data1,aes(x,y)) + geom_line() + labs(title = "Figure 1") + theme(plot.title = element_text(hjust = 0.5))
f2 <- ggplot(data2,aes(x,y)) + geom_line() + labs(title = "Figure 2") + theme(plot.title = element_text(hjust = 0.5))
f3 <- ggplot(data3,aes(x,y)) + geom_line() + labs(title = "Figure 3") + theme(plot.title = element_text(hjust = 0.5))
f4 <- ggplot(data4,aes(x,y)) + geom_line() + labs(title = "Figure 4") + theme(plot.title = element_text(hjust = 0.5))
f5 <- ggplot(data5,aes(x,y)) + geom_line() + labs(title = "Figure 5") + theme(plot.title = element_text(hjust = 0.5))
f6 <- ggplot(data6,aes(x,y)) + geom_line() + labs(title = "Figure 6") + theme(plot.title = element_text(hjust = 0.5))
(f1 + f2 + f3) / (f4 + f5 + f5) 
