
'mehrdad 

Sub summery()

For Each ws In Worksheets


  Dim ticker As String
  Dim volume As Double
  
  volume = 0


  volume = 0
  raw = 2
  lastrow = ws.Cells(Rows.Count, 1).End(xlUp).row

  For i = 2 To lastrow

      If Cells(i, 1).Value <> Cells(i + 1, 1).Value Then
           ticker = Cells(i, 1).Value
           Cells(raw, 9).Value = ticker
           volume = volume + Cells(i, 7).Value
           Cells(i, 9).Value = ticker
           ws.Range("J" & raw).Value = volume
           raw = raw + 1
      Else
           volume = volume + ws.Cells(i, 7).Value

      End If

  Next i

Next

End Sub
