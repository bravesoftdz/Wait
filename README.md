# Wait
Wait Solution (VCL/FMX)
Stop the Use of Stupid Sleep function !!
---------
  Now with this Solution :
  1) your Main thread Should Wait until your wait function finsh her work without freezing the entire App using the stupid Sleep function !!!
  2) other Threads that are runing outside your MainThread (they still could work without Any Problem!!)
  3) using the method ExecuteWork from ITask we can force the main thread App to wait until Our Task_Thread finish work
  4) the method ExecuteWork from ITask: (runs the task in the calling thread = the main App thread) and this like inject or create Smooth Thread inside the MainAppThread and this what we looking for ...
---------
Please Open The Master Branch !!
