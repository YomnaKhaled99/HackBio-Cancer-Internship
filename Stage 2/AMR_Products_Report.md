<!--StartFragment-->


# **AMR Products Data Analysis Report**

Authors (@slack): Merna Raafat Salem (@MernaSalem28), Yomna Khaled (@yomna98), Chijioke C. Uhegwu (@Chijioke001), Olorunfemi Omobolade (@Olorunfemi), Elizabeth Sayo (@Sayo)\
\---------------------------------------------------------------------------------------------------------------------


## **Project files**

### **Infographic summary:**

### As a pdf file 
<https://github.com/MernaSalem/hackbio-cancer-internship-/blob/main/Infographic%20summary/Infographic%20summary%20WHO%20AMR%20Products%20Data%20Analysis%20(2).pdf>

### As a markdown file
<https://github.com/MernaSalem/hackbio-cancer-internship-/blob/main/Infographic%20summary/Infograph.md>


### **R script:** 
<https://github.com/MernaSalem/hackbio-cancer-internship-/blob/main/Cleaning%20and%20Visualization%20WHO%20AMR%20Stage2.R>

This report outlines the analysis and key insights extracted from the WHO Antimicrobial Resistance (AMR) products dataset.


## **Data Preparation and Cleaning**

1. Data : The WHO AMR Products Dataset Was loaded into Rstudio

2. Unique and Most Repeated Values: they were identified to understand the structure of the dataset and assess the distribution of key variables.

3. Checking Missing Values: A detailed inspection of missing values across different columns .


## **Handling Missing Values**

- Replacing Values: Missing values were systematically replaced according to the nature of the data:

**Alternative Name**:  "-"  to  N/A, and "NA" to Unknown.

**Non-Traditional Categories**:  "NA"  to N/A.

**Mycobacterium tuberculosis**:  Missing entries were replaced with Not yet, and

"y" to Yes.

**Clostridioides difficile**:  "NA" to Null, "?" was converted to Unknown, and "y" to Yes.


## **Interactive Charts for Enhanced Understanding**

Within the code, you’ll find several interactive charts to provide deeper insights and enhance your understanding of the AMR product data. such as the distribution of R\&D phases, product types, and developer contributions.


## Key Insights and Summary : 

**1. Product Distribution:**

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXctfUNUuMTXtgkPsUXRa5AoJ5BiG8iCX5dRu-I70La2ICarpL2_QCXw3V2SopBvVGM_4szLc9YADX6V5SQEWcEofhn7Ki3njsap3XS42ewowAgscV8l1Lmvpzjg46RleTXLefEDHV0TJo-IY8wqQbOANrtp?key=Rnl2OMDbadKPPtZpXJp5eg)\
The dataset reveals that 57.2% of the products are Antibiotics, while 42.8% are Non-traditional  products, such as bacteriophages. This significant presence of non-traditional products shows that there is a growing focus on alternative approaches to combating AMR, an important trend in addressing resistance mechanisms that evade conventional antibiotics



**2. R\&D Phases:**

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXfUskHUx4WztGHGYeseFKRi7nipVeI4Mot2UFqtDoFyGp8VQkIfxcCPLA8IviBGvzAGkWP_4fPbWm5Ky2AN1rkK5-TIQxNWhpKJgMlaC4zyjWqF_jZizDI1GaU5At-CLPA0oDKH1RDp0yDy5Hlo-0Uy2fzz?key=Rnl2OMDbadKPPtZpXJp5eg)\
The majority of products are still in early development. Specifically, 46.3% of the products are in Phase I, followed by 27.8% in Phase II, and 21.8% in Phase III. Only 4.04% have reached the pre-registration phase. This distribution highlights the bottleneck in advancing products from early research to later stages of clinical trials, a common challenge in pharmaceutical R\&D .



**3. Key Indications and Bacteria:**

****![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXd3NH70PD2UByj1MubaarHi-Yut-cOTSPw-OGqFlxEoUEbp4EPPrTi6QoziC0Wzi9M7N0MbKDlKSr-sTTljhT3RHSunuZ4KvpSwnGrxxzX1PeHohTQ3r7t-FWy7Hurfv93jylnVOKakjl9KIHgVj-DPkjQq?key=Rnl2OMDbadKPPtZpXJp5eg)****

Gram-negative infections are a significant focus of many of these products. These infections are particularly dangerous due to the high resistance rate and the limited number of effective antibiotics available, emphasizing the urgent need for novel treatments.



**4. Top Developers:**

****![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXc3q7XIO1Q7pLbjaEMh0_vEA-VuGCijRF1Z31xyQmMrnYywnTxZseRM7cutff8Lr2GfmqlohkxcMV7_ICVO6lJMuWDZQ1jVFoDpRvaev5_6hCBvVTBLD94fXLCVpJ-zxIhBQJpxV9GcjDMZp4Dz3ClhQa1n?key=Rnl2OMDbadKPPtZpXJp5eg)****

Among the key players in AMR product development, companies like Qpex and GSK emerge as top contributors. These developers are leading the charge in both traditional antibiotics and non-traditional approaches.



**5. Top Antibacterial Classes:**

****![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXfv2mFFUsElefZPEpvRMX892Ky8mfPK40WWBQ2OoJVW88dghkkhFplvwSWJWtzhpDWXkaB119ugkbaSQJZwz6PVdYeBPk7nhYl1h-xJO3bAVyQGSKoCiDIvT9vLB5N37o2LwMxHDC1u1eludn2ouA9YWGUg?key=Rnl2OMDbadKPPtZpXJp5eg)****\
A breakdown of the antibacterial products reveals a concentrated effort on specific drug classes, reflecting the industry's prioritization of therapies targeting resistant bacterial strains.



## **Conclusion:**

The analysis presents a clear view of the AMR landscape, showing a strong focus on early-stage products and the emergence of non-traditional therapies. Monitoring the progress of key developers and the advancement of products targeting Gram-negative bacteria will be crucial in the fight against AMR.


<!--EndFragment-->
