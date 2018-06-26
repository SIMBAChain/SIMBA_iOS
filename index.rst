.. figure:: Simba-NS.png
   :align:   center
SIMBA_iOS
*********
Installation
============
* Hit the "Clone or download" button in upper right corner of the github page
* Hit the "Open in Xcode" button.
* Hit the "Open Xcode" button on the popup.
* Choose where you want to save the project and hit clone.
* Xcode should open the project.

Prerequisites
=============
.. note::
   stuff
These are already packaged in the app when you clone it.
--------------------------------------------------------
  * AlamoFire
  * Swagger


Usage
=====
There are several views in the app
----------------------------------
    * View Controller | This is the main view of the app here you can go to the other views as well as select an account.
    * Most Recent Audits Scene | This is the view that displays the last 10 audits you can click on any of them.
    * Detail View Controller  | This is the view that pops up whenever you click on one of the last 10 audits.
    * Post View Controller | This is the view where you can post items. Fields can be left empty or populated when posting.
Modifying/Setting up getting
----------------------------
      * Change the URL in "APIs.Swift"
      * Setup the model in "Model.Swift" under the folder "Models"
      * Change the path in "DefaultAPI.Swift" under the folder "APIs"
      * Setup the decoder in "Models.Swift"
      * Change the view controller to use the right data for the model
      * Change the view layout and outlets to fit the new model

Links
*****
  `Swagger <https://swagger.io/>`_
  
  `AlamoFire <https://github.com/Alamofire/Alamofire>`_
