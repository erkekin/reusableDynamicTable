reusableDynamicTable
====================

Table view is one of the most used component on the iOS so using it efficiently is crucial issue for avoiding memory waste. Using reusable cells which allows you to dequeue existing cell instead of creating new one is best way for maximum performance but it has a weakness. If you use any dynamic object on your cell like loading bar which activates on click, it copies loading bar to all of the newly displayed cells returned from dequeued cell.

So you would probably ask "how can i handle this problem?" and here is the answer **"reusableDynamicTable"**.

##How does it work?
It will download JSON (http://ios.anadolu.edu.tr/lab/getArray.php) and :

* When you click any row, it will get the corresponding "title" and the image link from JSON.
* Application starts download and updates the loading bar by calculating estimate download time remaining.
* If you click the downloading row, download will be cancelled.
* Each cell kept on Model separately so dequeue method works perfectly without copying components of cell.

