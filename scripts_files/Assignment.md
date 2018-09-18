Scripts are found in block_times/scripts as well as scripts_files/scripts

mrt-timing-01.sh and mrt_ folders relate to Part II: Reproduce RSFgen

mrt-timing-02.sh and mrt_ini folders relate to Part II: Control ITI

mrt-timing-03.sh and mrt_lnr folders relate to Part II: Limit the number of repetitions

Only 90 minutes late!  

The scripts are messy, but I'm aware of that and intend to clean them up later (or not).

### Q1

The structure of the best designed was spaced out fairly evenly, there weren't many clusters of stimuli.  If the stimuli are clustered the BOLD signal fails to settle after each stimulus, making it more difficult to detect a signicant BOLD effect.

### Q2

Terminal crashed halfway through the 5000 iterations and I don't have time to try running it again, so this is based on 500.

Stimuli are much more evenly distributed due to having intervals between.

### Q3

Based on 250 iterations due to time.

Not only are the stimuli more spaced out temporally, but they are ordered much more effectively.  The same stimulus doesn't occur consecutively.

### Q4

Optimal designs offer stimuli that are evenly spaced and non-consecutive, meaning stimuli of the same type do not occur back-to-back. 

### Q5

The efficiency for the contrasts are very similar for 20s and 50s, but jump up considerably for 100s.  A-C contrasts have slightly worse design efficiency for 20s and 50s, but much worse design efficiency for 100s.  Those differences in efficiency are due to the increased difference between 'steps'.  For example, the comparison between A(0) and C(200) is more significant than the difference between A(0) and B(100).

### Q6

The efficiency decreases as the -polort value increases.  I was at a loss for what -polart was doing, so I Googled it: the pnum value attached to -polort set the degree with which to model.  I'd assume that the high the value, the less 3dDeconvolve tries to model the baseline and thus the less efficient it is.  Somehow.

### Q7

An alternating block design that also includes a control block would be very effective.  The extended duration of the block would allow for each stimulus to have a pronounced effect and the control blocks would establish a baseline.

### Q8

Due to the sheer number of visual conditions an event-related design would be most effective as it would better allow for more in-depth comparisons between conditions.  Additionally, event-related designs can more effectively estimate the hemodynamic response, making it easier to infer the relative timing of neuronal activities. 