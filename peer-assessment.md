# Peer Assessment

## Automate - **NOT YET**

* The entire analysis is automated - _I think you still need to separate out the data loading and cleaning into a separate script, and incorporate other sites besides PRM. For PRM, your analysis looks great._
    * Data reading and cleaning is handled in a standalone script that creates intermediate output(s).
    * The analysis is performed in a Quarto document that reads intermediate outputs.
    * Files in the R/ folder exclusively define functions and have no other side effects.
    * All scripts run without errors.
* The analysis produces the expected output - _Still a work in process, but you're close._
    * The Quarto document performs the data analysis (moving average).
    * The Quarto document creates a figure that is a reasonable approximation of the original. - _Consider using facet grid() for the layout_

## Organize - **NOT YET**

* Data are properly organized - _Should have an output folder before you're done. Also, you're data is nicely organized and described, but you are storing A LOT of csvs that you're not using._
    * Raw data is contained in its own folder.
    * Outputs are contained in a separate folder from raw data.
* Code is properly organized - _I don't see any safety code._
    * At least one function is defined in a script in R/ and used elsewhere in the workflow.
    * All code in the repo (except in the scratch/ folder) is required for the analysis (i.e., no “safety blanket” code remaining)

## Document - **NOT YET**

* The repo has an effective README
    * A short, but descriptive title - _Accurate, but should be slightly different from the Schaefer paper_
        * A README’s title is set to the repository name by default - change this!
    * A brief explanation of the repository’s purpose - _Very good concise explanation._
        * Paragraphs or a bulleted list are both acceptable options
        * You may include an image or logo that represents the project
    * A concise description of what’s housed in the repository - _Good start, but you could include a few more numbered header categories for other folders (i.e. Paper, Docs, R, etc.)_
        * This includes information about the repository structure or file organization
    * Details regarding data access - _Perfect - forgot to add that in my own :)._
        * Any necessary information on where data lives (e.g. is it housed in the repo, on a server, in a library/package etc.) and how to access it in order to run the code
    * A list of authors or current contributors (for collaborative work) - _Great._
        * Consider hyperlinking collaborators’ GitHub profiles or other professional profile
    * References - _Don't forget to add the McDowell citation here too._
        * In an appropriate, consistent format, including links.
        * Don’t forget to add references for datasets too.
* Code follows a professional style
    * All code files follow a consistent style (the Air formatter automates this).
    * The code has an appropriate amount of comments.
        * Comments are minimized by using meaningful variable names and helper functions.
        * Comments are used to explain the why of code, not the what.
