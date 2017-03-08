This is a iOS project for 2017 Spring CSE498 Capstone Experience
It belongs to Team Amazon: Jie Wan, Ian Whalen, Tess Huelskamp, Ankit Luthra, Jason Liu

Our Amazon Customer Review Analyzer, ACRA, automatically classifies customer reviews into two categories, those related to product quality and those unrelated to product quality. To do so, ACRA uses natural language processing and machine learning.

This automatic classification of reviews allows Amazon shoppers to focus only on reviews that are relevant to product quality, thereby enhancing their shopping experience.

Amazon shoppers can search for products using our ACRA iPhone app, which separates reviews into product quality and non-product quality categories. Additionally, users can report misclassified reviews to refine and crowdsource our classifier’s performance.

Our iPhone application is written in Swift and communicates with our backend using API Gateway and Lambda hosted on Amazon Web Services (AWS). Amazon Machine Learning and Pythons NLTK library are used to classify reviews hosted in AWS’s S3 and DynamoDB.
