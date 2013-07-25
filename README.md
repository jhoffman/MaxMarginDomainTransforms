MaxMarginDomainTransforms
=========================
Author Judy Hoffman (jhoffman@eecs.berkeley.edu)

Package with code and demo usage for the paper:
"Efficient Learning of Domain-invariant Image Representations"
    J. Hoffman, E. Rodner, J. Donahue, K. Saenko, T. Darrell
    International Conference on Learning Representations (ICLR), 2013.

Setup:
------
- Edit the script "AddDependencies.m" to reference two directories
    - The path to liblinear_weights/matlab code available at
        http://www.csie.ntu.edu.tw/~cjlin/libsvmtools/#weights_for_data_instances
    - The path to Released code from Saenko et al available at 
        http://www1.icsi.berkeley.edu/~saenko/projects.html#DA
- Edit "Config.m" with desired parameters
    - Note if you wish to run experiments like in the paper, do not edit
      any parameters
- For running the demo script you must download data package at
    - http://www-scf.usc.edu/~boqinggo/domainadaptation.html#pub (code link at pub #1)
    - Once code is downloaded set the DATA_DIR parameter in Config.m to be
      the path to the dataset.

Run:
----
- To reproduce results from the paper run "demo.m" and pick the source and 
  target domains by changing the Config.m file.
- To run on new data you should look at TrainMmdt.m
    - [model, A] = TrainMmdt(labels, data, param)
    - Will return a model file that can be used with the predict() function
      from liblinear-weights
    - Must input a struct of the form labels.source, labels.target, data.source
      data.target. param should be a struct that contains the MMDT related
      parameters from Config.m (Namely: C_s, C_t, mmdt_iter)
