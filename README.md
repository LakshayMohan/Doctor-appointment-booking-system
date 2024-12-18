flowchart TD
    Start["Start (Login Page)"] --> AdminLogin["Admin Login"]
    Start --> PatientLogin["Patient Login"]
    Start --> DoctorLogin["Doctor Login"]
    
    PatientLogin --> PatientReg["Patient Registration"]
    DoctorLogin --> DoctorReg["Doctor Registration"]
    
    AdminLogin --> AdminDashboard["Admin Dashboard"]
    
    PatientReg --> PatientLogin["Patient Registered (Login Info)"]
    DoctorReg --> DoctorLogin["Doctor Registered (Login Info)"]
    
    PatientLogin --> PatientHome["Patient Homepage (Book/View Appointments)"]
    PatientHome --> BookApp["Book Appointment"]
    PatientHome --> ViewPatientApps["View Appointments (Status: Reviewed/Unreviewed)"]
    
    BookApp --> ChooseSpec["Choose Specialty"]
    ChooseSpec --> ViewDocs["View Doctors in Specialty"]
    ViewDocs --> SelectDate["Select Date"]
    SelectDate --> BookConfirm["Confirm Booking"]
    SelectDate --> AppLimitError["Error: Doctor Fully Booked"]
    BookConfirm --> ViewPatientApps
    
    DoctorLogin --> DoctorHome["Doctor Homepage (View Appointments)"]
    DoctorHome --> UpdateStatus["Update Status to Reviewed"]
    UpdateStatus --> DoctorHome["Status Updated"]
