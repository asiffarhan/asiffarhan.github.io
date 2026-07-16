Add-Type -AssemblyName System.Drawing

function Save-Logo {
    param(
        [string]$Path,
        [scriptblock]$Draw
    )

    $bmp = New-Object System.Drawing.Bitmap 128,128
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit
    & $Draw $g
    $bmp.Save($Path, [System.Drawing.Imaging.ImageFormat]::Png)
    $g.Dispose()
    $bmp.Dispose()
}

Save-Logo "assets/png/openfoam.png" {
    param($g)
    $g.Clear([System.Drawing.Color]::FromArgb(243,116,40))
    $brush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::White)
    $font = New-Object System.Drawing.Font('Segoe UI',18,[System.Drawing.FontStyle]::Bold)
    $sf = New-Object System.Drawing.StringFormat
    $sf.Alignment = [System.Drawing.StringAlignment]::Center
    $sf.LineAlignment = [System.Drawing.StringAlignment]::Center
    $g.DrawString('Open', $font, $brush, [System.Drawing.RectangleF]::new(0,18,128,36), $sf)
    $g.DrawString('FOAM', $font, $brush, [System.Drawing.RectangleF]::new(0,54,128,36), $sf)
    $pen = New-Object System.Drawing.Pen([System.Drawing.Color]::White, 8)
    $g.DrawCurve($pen, @(New-Object System.Drawing.Point 20 98, New-Object System.Drawing.Point 44 70, New-Object System.Drawing.Point 64 100, New-Object System.Drawing.Point 84 70, New-Object System.Drawing.Point 108 98), 0.5)
}

Save-Logo "assets/png/tecplot.png" {
    param($g)
    $g.Clear([System.Drawing.Color]::FromArgb(14,75,149))
    $brush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::White)
    $font = New-Object System.Drawing.Font('Segoe UI',18,[System.Drawing.FontStyle]::Bold)
    $sf = New-Object System.Drawing.StringFormat
    $sf.Alignment = [System.Drawing.StringAlignment]::Center
    $sf.LineAlignment = [System.Drawing.StringAlignment]::Center
    $g.DrawString('tecplot', $font, $brush, [System.Drawing.RectangleF]::new(0,26,128,44), $sf)
    $pen = New-Object System.Drawing.Pen([System.Drawing.Color]::White, 7)
    $g.DrawCurve($pen, @(New-Object System.Drawing.Point 16 94, New-Object System.Drawing.Point 36 66, New-Object System.Drawing.Point 62 82, New-Object System.Drawing.Point 86 42, New-Object System.Drawing.Point 110 72), 0.4)
}
