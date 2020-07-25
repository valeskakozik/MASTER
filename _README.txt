README SELECTION_SCORING
Valeska Kozik, July 2020

The MATLAB script SELECTION_SCORING scores performance on the OCS-Plus Selection task in both conditions (Feedback (FB) and No Feedback (NFB)). 
You can run the script either by pressing 'RUN' when the script is open, or by adding its path to the MATLAB path and typing SELECTION_SCORING in the command window.
It should run on any operating system (tested in Windows and macOS).

In the beginning, it prompts you to select an input folder, in which the raw data is stored.
This script only works, if the input folder structure looks as follows.
(This file package includes mock data in the right format, you can run the script as is.)

_WhateverFolder (<- choose this one when prompted! The name is irrelevant (e.g. 'Data', 'Particpipants'...)
__ Controls
___ Control_ID_1 (e.g. 'C0001', 'A0002')
____ SELECTION_data_XXX.mat (for the script to recognise the file, it needs to start with 'SELECTION_data' and have a '.mat' extension (visible or not))
___ Control_ID_2
___ ...
__ Patients
___ Patient_ID_1
____ ...


It then creates an output folder on the same level as the input folder you chose and in it saves a comma separated spreadsheet with each row representing one particpant.
It creates the following variables:
1. ID
2. Group (0 = controls, 1 = patients)
*For FB and NFB each:*
3. Accuracy
4. Time
5. Median Latency
6. Median Distance
7. Median Search Speed
8. Number of search paths which crossed an earlier path (intersections)
9. Number of intersections adjusted by number of sequentially different markings
10. Best R
11. False positives
12. Correct revisits
13. Incorrect revisits
14. Consecutive revisits
15. Nonconsecutive revisits
16. Total revisits

**References for the OCS-Plus and the further measures**
Demeyere, N., Haupt, M., Webb, S. S., Strobel, L., Milosevich, E., Moore, M. J., . . . Duta, M. (2020). The Oxford Cognitive Screen–Plus (OCS-Plus): a tablet based short cognitive screening tool for milder cognitive impairment.
Mark, V. W., Woods, A., Ball, K., Roth, D. L., & Mennemeier, M. (2004). Disorganized search on cancellation is not a consequence of neglect. Neurology, 63(1), 78-84. 
Rabuffetti et al.(2012). Spatio-Temporal Features of Visual Exploration in Unilaterally Brain-Damaged Subjects withor without Neglect: Results from a Touchscreen Test. PLoS ONE, 7(2),e31511. doi:10.1371/journal.pone.0031511



