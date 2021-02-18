# Homework 2

### recognizeObjects file

Takes absolute value of roundness of test image minus roundness of  object image, and divides the roundness of  object image
```
diff = abs(test_pro(6) - obj_db(6))/(obj_db(6));
```
If diff is smaller than 0.1 than found the object
