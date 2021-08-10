# Homework 3

### generateHoughAccumulator():
I used 1000 as `rho_num_bins` and 250 as` theta_nums_bins`. The main reason I choose those number is realted to the diagonal size of the picture. The size of the pictures are `640 x 426`, and the diagonal is around 800, and I used 1000 for error tolerance. Simiarly, the theta space can be represented by 180 degrees, and 180/0.75 = 240, approximately 250. For voting scheme, I choose not to use just nearby bins, but the accumlator array.

### lineFinder():
Since we aleardy have the Housh accumulater from `generateHoughAccumulator( )`, we can just use a threshold method to find the peaks in images. And also I adjust the peak value to make sure there isn't too much overlapping edge and the essential outline are detected. 

### lineSegmentFinder():
The main algorithm used in the function use both `lineFinder()` funtion and build-in edge function. After I got line image and edge image, the dilation was appyied to edge image. When the value is non-negtive  that means the point is nearly by the edge then we could keep it, otherwise we don't save it.
