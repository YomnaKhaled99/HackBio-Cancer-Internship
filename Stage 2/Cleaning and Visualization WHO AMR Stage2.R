library(ggplot2)
library(plotly)
library(stringr)
library(tidyverse)
library(readr)
library(dplyr)

#Data uploading
amr_data <- read_tsv("WHO_AMR_PRODUCTS_DATA.tsv.txt")
glimpse(amr_data)
unique_values <- lapply(amr_data, unique)
write.csv(amr_data, file = "C:/Users/hp/Documents/project-1/HackBioStage-2 Task ( AMR )/amr_data.csv", row.names = FALSE)

#Checking missing values
sum(is.na(amr_data))
total_missing <- sum(is.na(amr_data))
total_values <- prod(dim(amr_data))
percentage_missing <- (total_missing / total_values) * 100
percentage_missing

# Check the structure and summary of missing values
sapply(amr_data, function(x) sum(is.na(x)))
missing_percentage <- colMeans(is.na(amr_data)) * 100
print(missing_percentage)

#Handling missing values
cleaned_amr_data <- amr_data %>%
  # Clean the 'Alternative name' column
  mutate(`Alternative name` = ifelse(`Alternative name` == "-", "N/A", `Alternative name`)) %>%
  mutate(`Alternative name` = replace_na(`Alternative name`, "Unknown")) %>%
  # Clean the 'Non-traditionals categories' column
  mutate(`Non-traditionals categories` = ifelse(is.na(`Non-traditionals categories`), "N/A", `Non-traditionals categories`)) %>%
  
  # Clean the 'Mycobacterium tuberculosis' column
  mutate(`Mycobacterium tuberculosis` = ifelse(is.na(`Mycobacterium tuberculosis`), "Not yet", 
                                               ifelse(`Mycobacterium tuberculosis` == "y", "Yes", `Mycobacterium tuberculosis`))) %>%
  
  # Clean the 'Clostridioides difficile' column
  mutate(`Clostridioides difficile` = ifelse(is.na(`Clostridioides difficile`), "Null", 
                                             ifelse(`Clostridioides difficile` == "?", "Unknown", 
                                                    ifelse(`Clostridioides difficile` == "y", "Yes", `Clostridioides difficile`))))
write.csv(cleaned_amr_data, "cleaned_amr_data.csv", row.names = FALSE)

#Check missing values in the new table
sum(is.na(cleaned_amr_data))
total_missing <- sum(is.na(cleaned_amr_data))
total_values <- prod(dim(cleaned_amr_data))
percentage_missing <- (total_missing / total_values) * 100
percentage_missing
sapply(cleaned_amr_data, function(x) sum(is.na(x)))

#Visualization
# Calculate the counts for each Product Type
product_type_counts <- cleaned_amr_data %>%
  group_by(`Product type`) %>%
  summarise(count = n(), .groups = 'drop')

# Create a pie chart
plot_ly(product_type_counts, labels = ~`Product type`, values = ~count, type = 'pie', 
        textinfo = 'label+percent', hoverinfo = 'label+percent+value',
        marker = list(colors = c('#C0D0B0', '#8A9A5B'))) %>%
  layout(title = 'Distribution of Product Types')

# Pie Chart for R&D Phase using plotly
phase_counts <- cleaned_amr_data %>%
  count(`R&D phase`)

# Create a pie chart using plotly# Create a pie chart using plotly and customize colors
plot_ly(phase_counts, labels = ~`R&D phase`, values = ~n, type = 'pie', 
        textinfo = 'label+percent', hoverinfo = 'label+percent+value',
        marker = list(colors = c('#C0D0B0', '#D0D8C0', '#6F8F6F', '#8A9A5B'))) %>%
  layout(title = 'Distribution of Products in Each R&D Phase')

# Pie chart for the Non-traditional categories
Nontraditional <- cleaned_amr_data %>%
  count(`Non-traditionals categories`)
# Create an interactive pie chart using Plotly
plot_ly(Nontraditional, labels = ~`Non-traditionals categories`, values = ~n, type = 'pie', 
        textinfo = 'label+percent', hoverinfo = 'label+percent+value',
        marker = list(colors = c('#C0D0B0', '#D0D8C0', '#6F8F6F', '#8A9A5B', 'darkgreen','lightgray'))) %>%
  layout(title = 'Distribution of Non-traditionals categories')

#Creates an interactive pie chart showing antibacterial class distribution with hover details 
antibacterial_class_counts <- cleaned_amr_data %>%
  group_by(`Antibacterial class`) %>%
  summarise(count = n())
plot_ly(antibacterial_class_counts, labels = ~`Antibacterial class`, values = ~count, type = 'pie', 
        textinfo = 'label+percent', hoverinfo = 'label+percent+value') %>%
  layout(title = 'Antibacterial Class Distribution')

# Group data by 'Antibacterial class', calculate counts, and select top 3
antibacterial_class_counts_bar <- cleaned_amr_data %>%
  group_by(`Antibacterial class`) %>%
  summarise(count = n()) %>%
  arrange(desc(count)) %>%
  top_n(3, count)

# Create a bar chart using Plotly
plot_ly(antibacterial_class_counts_bar, x = ~`Antibacterial class`, y = ~count, type = 'bar', 
        text = ~count, textposition = 'auto', hoverinfo = 'text',
        marker = list(color = '#6F8F6F')) %>%
  layout(title = 'Top 3 Antibacterial Class', 
         xaxis = list(title = 'Antibacterial Class'),
         yaxis = list(title = 'Count'))

#Creates an interactive pie chart showing indications distribution with hover details 
indications_class_counts <- cleaned_amr_data %>%
  group_by(`Indications`) %>%
  summarise(count = n())
plot_ly(indications_class_counts, labels = ~`Indications`, values = ~count, type = 'pie', 
        textinfo = 'label+percent', hoverinfo = 'label+percent+value') %>%
  layout(title = 'Indications Distribution')

# Group data by 'Indications', calculate counts, and select top 3
Indications_class_counts_bar <- cleaned_amr_data %>%
  group_by(`Indications`) %>%
  summarise(count = n()) %>%
  arrange(desc(count)) %>%
  top_n(3, count)

# Create a bar chart using Plotly
plot_ly(Indications_class_counts_bar, x = ~`Indications`, y = ~count, type = 'bar', 
        text = ~count, textposition = 'auto', hoverinfo = 'text',
        marker = list(color = '#6F8F6F')) %>%
  layout(title = 'Top 3 Indications', 
         xaxis = list(title = 'Indications'),
         yaxis = list(title = 'Count'))


# Group data by 'Developer', calculate counts, and select top 3
Developer_class_counts <- cleaned_amr_data %>%
  group_by(`Developer`) %>%
  summarise(count = n()) %>%
  arrange(desc(count)) %>%
  top_n(3, count)

# Create a bar chart using Plotly
plot_ly(Developer_class_counts, x = ~`Developer`, y = ~count, type = 'bar', 
        text = ~count, textposition = 'auto', hoverinfo = 'text',
        marker = list(color = '#6F8F6F')) %>%
  layout(title = 'Top 3 Developers', 
         xaxis = list(title = 'Developers'),
         yaxis = list(title = 'Count'))

# Replace 'N/A' with 'Unknown' in 'Active against priority pathogens?'
cleaned_amr_data <- mutate(cleaned_amr_data, across('Active against priority pathogens?', ~ str_replace(., 'N/A', 'Unknown')))
# Grouping by 'Route of administration', 'Product name', and 'R&D phase'
roa <- group_by(cleaned_amr_data, `Route of administration`, `Product name`, `R&D phase`)
# Count of products by route of administration and R&D phase
route_effectiveness <- cleaned_amr_data %>%
  group_by(`Route of administration`, `R&D phase`) %>%
  summarise(count = n(), .groups = 'drop')
# Plot the distribution by route of administration and R&D phase
ggplot(route_effectiveness, aes(x = `Route of administration`, y = count, fill = `R&D phase`)) +
  geom_bar(stat = "identity", position = "dodge" ) +
  labs(title = "Distribution of Products by Route of Administration and R&D Phase", 
       x = "Route of Administration",
       y = "Number of Products") +
  scale_fill_manual(values = c('#D0D8C0', '#6F8F6F', '#8A9A5B', 'darkgreen')) +
  theme_minimal()

# Count of effective products by R&D phase
efficacy_counts <- cleaned_amr_data %>%
  group_by(`R&D phase`, `Active against priority pathogens?`) %>%
  summarise(count = n(), .groups = 'drop')
# Plot the efficacy across R&D phases
ggplot(efficacy_counts, aes(x = `R&D phase`, y = count, fill = `Active against priority pathogens?`)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Efficacy of Products Against Priority Pathogens Across R&D Phases",
       x = "R&D Phase",
       y = "Count") +
  scale_fill_manual(values = c('#D0D8C0', '#6F8F6F', '#8A9A5B', 'darkgreen')) +
  theme_minimal()

# Subset data for Phase I
roa_phase1 <- roa[roa$`R&D phase` == "Phase I", ]
# Distribution of AMR products in Phase I using different colors for different routes of administration
ggplot(roa_phase1, aes(x = `Product name`, fill = `Route of administration`)) +
  geom_bar() +
  coord_flip() +
  labs(title = "Distribution of AMR Products in Phase I",
       x = "Product name",
       y = "Number of cases") +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5))

#2-2 product name and route of admission (interactive)
ggplotly(ggplot(cleaned_amr_data, aes(x = `Product name`, fill = `Route of administration`)) +
           geom_bar() + coord_flip() +
           labs(title = "Relation between Product Name and Route of Administration") +
           theme_minimal())

#3 Subset data for Phase I and IV route of administration
roa_phase1_1 <- roa_phase1[roa_phase1$`Route of administration` == "IV", ]
# Heatmap of product name against pathogen name and activity for Phase I IV-administered products
ggplot(roa_phase1_1, aes(x = `Product name`, y = `Pathogen name`)) +
  geom_tile(aes(fill = `Active against priority pathogens?`)) +
  scale_fill_brewer(palette = "Blues") +
  labs(title = "Effect of Phase I IV-administered products on pathogens",
       x = "Product name",
       y = "Pathogen name") +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5), axis.text.x = element_text(angle = 45, hjust = 1))

#Count of products active against priority pathogens across different R&D phases

# Visualizations of activity against priority pathogens across phases

# Trial 1: Jitter plot
ggplot(roa, aes(x = `R&D phase`, y = `Active against priority pathogens?`)) +
  geom_jitter() +
  labs(title = "Activity against priority pathogens across different phases",
       x = "Phase",
       y = "Activity") +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5))


# Trial 2: Bubble plot
ggplot(efficacy_counts, aes(x = `R&D phase`, y = `Active against priority pathogens?`, size = count, color = count)) +
  geom_point() +
  labs(title = "Activity against priority pathogens across different phases",
       x = "Phase",
       y = "Activity") +
  scale_size_continuous(range = c(3, 18)) +  # Adjust point sizes
  scale_color_gradient(low = "blue", high = "red") +  # Color by count
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5))

# Show which pathogens are targeted by which products, using a heatmap
ggplot(cleaned_amr_data, aes(x = `Product name`, y = `Pathogen name`)) + 
  geom_tile(aes(fill = `Pathogen activity`)) +
  scale_fill_manual(values = c("lightblue", "darkblue", "green", "yellow")) +  # Customize colors for each category
  labs(title = "Heatmap of Pathogens vs AMR Products",
       x = "Product",
       y = "Pathogen") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

#the count of each product, grouped by whether they are classified as NCE or not.
ggplot(cleaned_amr_data, aes(x = `Product name`, fill = `NCE?`)) +
  geom_bar(position = "dodge") +
  labs(title = "Relation between Product Name and NCE Status",
       x = "Product Name",
       y = "Count of Products",
       fill = "NCE") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

#the different levels of pathogen activity within each pathogen name (interactive)
p <- ggplot(cleaned_amr_data, aes(x = `Pathogen name`, fill = `Pathogen activity`)) +
  geom_bar(position = "stack") +
  labs(title = "Stacked Bar Chart of Pathogen Activity by Pathogen Name",
       x = "Pathogen Name",
       y = "Count of Pathogens",
       fill = "Pathogen Activity") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
ggplotly(p)
# Group the data by Pathogen name and Pathogen activity and calculate counts
pathogen_data <- cleaned_amr_data %>%
  group_by(`Pathogen name`, `Pathogen activity`) %>%
  summarise(count = n()) %>%
  ungroup()

# Create a pie chart using Plotly for pathogen activity distribution
plot_ly(pathogen_data, labels = ~`Pathogen activity`, values = ~count, type = 'pie', 
        textinfo = 'label+percent', hoverinfo = 'label+percent+value', 
        marker = list(colors = colorRampPalette(c('#6F8F6F', '#D0D8C0', '#8A9A5B', 'darkgreen'))(length(unique(pathogen_data$`Pathogen activity`))))) %>%
  layout(title = "Distribution of Pathogen Activity by Pathogen Name",
         showlegend = TRUE)

# Create a bar plot for Clostridioides difficile column
ggplot(cleaned_amr_data, aes(x = `Clostridioides difficile`)) +
  geom_bar(fill = "darkgreen") +
  theme_minimal() +
  labs(title = "Distribution of Products' Effectiveness Against Clostridioides difficile",
       x = "Effectiveness Against C. difficile",
       y = "Count of Products") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Rotating x-axis labels for readability


# Create a bar plot showing products' effectiveness against C. difficile

ggplot(cleaned_amr_data, aes(x = `Clostridioides difficile`, fill = `Product name`)) +
  geom_bar() +
  geom_text(stat='count', aes(label=..count..), vjust=-0.5) +
  theme_minimal() +
  labs(title = "Products' Effectiveness Against Clostridioides difficile",
       x = "Effectiveness Against C. difficile",
       y = "Count of Products") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  guides(fill=guide_legend(title="Product Name"))


# an interactive heatmap of product vs pathogen (interactive)
ggplotly(ggplot(cleaned_amr_data, aes(x = `Product name`, y = `Pathogen name`, fill = `Active against priority pathogens?`)) + 
           geom_tile() + scale_fill_brewer(palette = "Blues"))
