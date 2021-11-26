library(rvest)
library(dplyr)
library(stringr)

link = "https://www.worldometers.info/coronavirus/"
page = read_html(link)

name = page %>% html_nodes("td:nth-child(2)") %>% html_text()
total = page %>% html_nodes("td:nth-child(3)") %>% html_text()
new_cases = page %>% html_nodes("td:nth-child(4)") %>% html_text()
total_deaths = page %>% html_nodes("td:nth-child(5)") %>% html_text()
new_deaths = page %>% html_nodes("td:nth-child(6)") %>% html_text()
total_recovered = page %>% html_nodes("td:nth-child(7)") %>% html_text()
new_recovered = page %>% html_nodes("td:nth-child(8)") %>% html_text()
active_cases = page %>% html_nodes("td:nth-child(9)") %>% html_text()
critical_cases = page %>% html_nodes("td:nth-child(10)") %>% html_text()
population = page %>% html_nodes("td:nth-child(15)") %>% html_text()

df = data.frame(name, total, new_cases, total_deaths, new_deaths, total_recovered, new_recovered,
                active_cases, critical_cases, population)
df

df_cont = df[1:6,]
df_cont[1] = sapply(df_cont[1], function(x) { gsub("[\r\n]", "", x) })
head(df_cont)

df_country = df[-1:-7,]
df_country = df_country[1:225,]
df_country[1] = sapply(df_country[1], function(x) { gsub("[\r\n]", "", x) })
head(df_country)

scriptDir <- dirname(rstudioapi::getSourceEditorContext()$path)

write.csv(df_country, paste(scriptDir, "covid_by_country.csv", sep = "/"), row.names = FALSE)
write.csv(df_cont, paste(scriptDir, "covid_by_continent.csv", sep = "/"), row.names = FALSE)