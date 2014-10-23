---
layout: post
title: "Export PNG charts from Excel"
description: ""
category: "blog"
tags: [PNG, beamer, Excel, LaTeX]
---

Excel cannot directly export charts or `Save As` in other image formats,
but with a simple macro one can export charts in `PNG` format.
This format is great for including charts in LaTeX documents
with `\includegraphics{chart.png}`.

The macro can be stored in the personal macro file `PERSONAL.XLSB`.
Excel 2010 places the file in the following location:
`C:\Users\yourusername\AppData\Roaming\Microsoft\Excel\XLSTART`

This file is hidden when first starting Excel. To unhide, perform
the following steps.

    + View -> Unhide
        + Unhide personal macros file.

You can now select the `View -> Macro` or the `Developer -> Macros` menu items to create a new macro.
The macro for saving the generated `PNG` files is as follows:

```
Sub Export_ActiveChart_as_PNG()
'
' Export_ActiveChart_as_PNG Macro
' Export Active Chart as PNG
'
        ActiveChart.Export Filename:="C:\path\to\save\excelcharts\" & ActiveSheet.Name & ".png", Filtername:="PNG"

End Sub
```

The generated `PNG` file can now be used in `tex` documents as usual.

Today, however, I found another alternative, but it doesn't work as well. 

# Save chart as `PDF`

Excel 2010 provides a `Save As` option that can save the active chart as a `PDF` file. 
The file can be used directly with `\includegraphics{chart.pdf}` 
but the resulting `PDF` has a significant white margin all around that 
would have to be cropped for better results. 
Cropping a `PDF` without the full version of Acrobat can be a problem, so the `PNG` route works  better, in my opinion.
