---
description: Learn how to use text and images on the program.
---

# Text and Images

Text and images are important to the game. They are the visuals and what the player sees in the game.

## text.\(filetype\)

You can put "text.\(filetype\)" in your part folder. This is used to make text in the program. Text overlap images in TAC.

Here is how the setup of the file works.

```text
Whatever text here. # extremely long text might go out of the screen, making it invisible
x of where the first letter starts. # must be a number (less than the size of the x of the screen but more than or equal to 0)
y of where the first letter starts. # must be a number (less than the size of the x of the screen but more than or equal to 0)
foreground color of the text
background color of the text # leave this as "?" to not set the background color.
font file (fonts must in the folder "data\fonts\") # leave this as "?" to set it as the default font.
font size # leave this as "?" if you set the font file as "?". you can not control the default font's size.
```

This can be looped over and over again.  
Example:

```text
Hello!
0
0
ffffff
?
?
?
How are you doing?
0
10
ffffff
?
?
?
I'm blue!
0
20
0000FF
?
?
?
```

This should look like:

![Output of the program.](../.gitbook/assets/image.png)

## images.\(filetype\)

