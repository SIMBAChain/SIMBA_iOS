.. figure:: Simba-NS.png
   :align:   center
   
SIMBA_iOS
*********

Installation
************

* Hit the "`Clone or Download <Install1.html>`_" button in upper right corner of the github page
* Hit the "`Open in Xcode <Install2.html>`_" button.
* Hit the "`Open Xcode <Install3.html>`_" button on the popup.
* Choose where you want to `save the project <Install4.html>`_ and hit clone.
* Xcode should `open the project <Install5.html>`_.

Prerequisites
*************
.. note::
  These are already packaged in the app when you clone it.

  * AlamoFire
  * Swagger


Usage
*****

There are several views in the app
==================================

    * `View Controller <https://github.com/SIMBAChain/SIMBA_iOS/blob/master/ScreenShots/View%20Controller.png>`_ | This is the main view of the app here you can go to the other views as well as select an account.
    * `Most Recent Audits Scene <https://github.com/SIMBAChain/SIMBA_iOS/blob/master/ScreenShots/Most%20Recent%20Audits%20Scene.png>`_ | This is the view that displays the last 10 audits you can click on any of them.
    * `Detail View Controller <https://github.com/SIMBAChain/SIMBA_iOS/blob/master/ScreenShots/Detail%20View%20Controller.png>`_  | This is the view that pops up whenever you click on one of the last 10 audits.
    * `Post View Controller <https://github.com/SIMBAChain/SIMBA_iOS/blob/master/ScreenShots/Post%20View%20Controller.png>`_ | This is the view where you can post items. Fields can be left empty or populated when posting.

Modifying/Setting up "getting"
============================

      * Change the URL in "`APIs.Swift <https://github.com/SIMBAChain/SIMBA_iOS/blob/master/ScreenShots/APIs.png>`_"
      * Setup the model in "`Model.Swift <https://github.com/SIMBAChain/SIMBA_iOS/blob/master/ScreenShots/Model.png>`_" under the folder "Models"
      * Change the path in "`DefaultAPI.Swift <https://github.com/SIMBAChain/SIMBA_iOS/blob/master/ScreenShots/DefaultAPI.png>`_" under the folder "APIs"
      * Setup the decoder in "`Models.Swift <https://github.com/SIMBAChain/SIMBA_iOS/blob/master/ScreenShots/Models.png>`_"
      * Change the `view controller <https://github.com/SIMBAChain/SIMBA_iOS/blob/master/ScreenShots/AuditViewController.png>`_ to use the right data for the model
      * Change the `view layout and outlets <https://github.com/SIMBAChain/SIMBA_iOS/blob/master/ScreenShots/Outlets.png>`_ to fit the new model

Links
*****
  `Swagger <https://swagger.io/>`_
  
  `AlamoFire <https://github.com/Alamofire/Alamofire>`_
  
  `Github Repo <https://github.com/SIMBAChain>`_
  
  `SIMBA Website <https://simbachain.com/>`_
  
.. _links:

.. toctree::
   :maxdepth: 2
   :caption: Links

   install1
   install2
   install3
   install4
   install5
   APIs
   AuditViewController
   DefaultAPI
   DetailViewController
   Model
   Models
   MostRecentAuditScene
   Outlets
   PostViewController
   ViewController
