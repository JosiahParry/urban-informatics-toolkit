# Ecometrics

Central to the work that is done at BARI are the development and utilization of  **ecometrics**. Ecometrics represent a quantitative representation of physical and social environment. In the Urban Informatics context, ecometrics are created to extract **latent constructs**—or variables that can only be inferred from a dataset—that illustrate some physical or social phenomenon. 

To understand this, we need to again contextualize these datasets. They _are not_ created with the intention of beng analyzed or to measure the blight of a neighborhood or the social unrest of a city. The data may tell a story of an underserved neighborhood or of a gilded community with a beautiful brick façade with next to no collective efficacy efforts. These datasets contain gems—beautifully inelegant snapshots of the societal quotidien. But measuring that? That's the tough part and that is why we create ecometrics. They provide us with a way to adapt existing data to address new problems.

Of the work that BARI conducts, the production of city-wide ecometrics of social and physical disorder are most emblematic of this hybrid approach. To understand this work we need to venture back to 1982 and an article from the Atlantic called _Broken Windows_.

## Broken Windows Theory

During the beginning of the crack-cocaine epidemic George Kelling and James Wilson wrote a now [in]famous article titled _Broken Windows_ which outlined a new theory to explain the occurrence of crimes. The premise of this article is that the _presence_ of disorder is more concerning for a neighborhoods residents than the actual crime that occurs. Further, the "visual cues of disorder . . . begets predatory crime and neighborhood decline" (O'Brien and Sampson, 2015).

Broken Windows captured the eyes of pundits and policy makers. The simplicity of the theory makes it easy to  Broken windows has historically captured the attention of policy makers. The vast public support has led to a large body of work largely disputing the merits of this theory. In the process of doing so, much work has gone into actually quantifying disorder in a city. In a seminal article by Sampson and Raudenbush (1999), the practice of systematic social observation was created. This is a process in which imagery of public spaces is taken and coded to identify disorder—i.e. the presence of empty beer cans—which can then be quantitatively analyzed. This is an early example of an ecometric. 

## Quantifying Disorder 

In 2015, O'Brien and Sampson published the article _Public and Private Spheres of Neighborhood Disorder: Assessing Pathways to Violence Using Large-scale Digital Records_. This article epitomizes the hybrid aproach to urban studies. In it, O'Brien and Sampson utilize 911 dispatches and 311 call data to create measures of both social and physical disorder. These measures were then used to put Broken Windows theory to the test. The process of using existing administrative datasets as a method of estimating social and physical phenomena illustrates the inductive approach. Whereas testing testing the efficacy of Broken Windows is indicative of the more traditional deductive process.

Quantifying disorder is no small task. In their 2015 paper the authors write 

> Taking up this challenge, O’Brien, Sampson, and Winship (2015) have proposed a methodology for ecometrics in the age of digital data, identifying three main issues with such data and articulating steps for addressing each. These are (1) identifying relevant content, (2) assessing validity, and (3) establishing criteria for reliability. 

The above is an astute summation of the problems that arise with big data and how they can be overcome. The biggest of concerns, as mentioned in the opening of this section, is the validity of the data we are using. 

### Defining the phenomenon

The method that they propose requires us to do three main The first is to clearly define the phenomenon that we are hoping to measure. Following, we must idenify the **relevant data**. For example, in O'Brien and Sampson (2015), they define five ecometrics as 


> * Public social disorder, such as panhandlers, drunks, and loud disturbances;
* Public violence that did not involve a gun (e.g., fight);
* Private conflict arising from personal relationships (e.g., domestic
violence);
* Prevalence of guns violence, as indicated by shootings or other inci-
dents involving guns; and
* Alcohol, including public drunkenness or public consumption of
alcohol.

These definitions provide clear pictures as to what is being measured. The next step is to surf through your data and do your best to match variables or observations to these measures. Then, through some process—usually factor analys—ensure that these measures are truly relevant. 

### Validating the measure 

Once an ecometric has been defined and properly measured, the next step is to validate it. I think of this process similar to ground truthing in the geospatial sciences. Often when geographic coordinates are recorded an individual will go to that physical location and ensure that whatever that was recorded to be there actually is. This is what we are doing with our ecometrics. We have developed our measures, but we need to compare that to some objective truth so to say. 

In Sampson & Raudenbush (1999), they develop measures of physical disorder through their systematic social observation. But in order to validate their measures, they compared their results to those of a neighborhood audit. This audit served as their ground truth and was used to make any adjustments if needed. 

### Addressing reliability

This ecometric, like most others, are naturually time bound snapshots of the social and physical world. These measures will naturally change over time. Because of this it is useful to know both how reliable the measure will be for different periods of time (O'Brien, Sampson, and Winship, 2015). The authors do with with a bit of statistical finesse that is best left to them to explain. But what we are to take away is that ecometrics are often time variant and it is important for us to know at what time scale the ecometrics are intended for. 

References & Readings: 

- O’Brien, Daniel Tumminelli, Robert J. Sampson, and Christopher Winship. 2015.
‘‘Ecometrics in the Age of Big Data: Measuring and Assessing ‘Broken Windows’
Using Large-scale Administrative Records.’’ Sociological Methodology 45.
- https://www.annualreviews.org/doi/abs/10.1146/annurev-criminol-011518-024638?journalCode=criminol
- Large-scale data use, ecometrics to assess disorder: https://journals.sagepub.com/doi/abs/10.1177/0022427815577835
- sampson & raudenbush systematic social observation: https://www.journals.uchicago.edu/doi/abs/10.1086/210356

