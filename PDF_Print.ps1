# Set the path to the directory containing PDF files
$pdfDirectory = ".\"

# Set the path to Acrobat.exe
$acrobatPath = "C:\Program Files\Adobe\Acrobat DC\Acrobat\Acrobat.exe"

# Get all PDF files in the specified directory
$pdfFiles = Get-ChildItem -Path $pdfDirectory -Filter "*.pdf"

# Define the total number of PDF files
$totalFiles = $pdfFiles.Count

# Initialize a counter for the progress
$progressCounter = 0

# Loop through each PDF file
foreach ($pdfFile in $pdfFiles) {
    # Increment the progress counter
    $progressCounter++

    # Calculate the percentage completed
    $percentageComplete = ($progressCounter / $totalFiles) * 100

    # Start Acrobat and print the PDF file
    Start-Process -FilePath $acrobatPath -ArgumentList "/t `"$($pdfFile.FullName)`""

    # Display progress
    Write-Progress -Activity "Printing PDF Files" -Status "Printing $pdfFile" -PercentComplete $percentageComplete

    # Wait for 10 seconds
    Start-Sleep -Seconds 10

    # Terminate Acrobat process
    Get-Process | Where-Object {$_.Name -eq "Acrobat"} | Stop-Process -Force
}

# Complete the progress bar
Write-Progress -Activity "Printing PDF Files" -Status "Printing Complete" -Completed