#!/bin/env python 
# friction loss (FL) = coefficient(C) * (gpm(Q) / 100) ^2 * length(L) / 100

import os
run = True 
while run :

  os.system('clear')

  print(" Diameter  Coefficient")
  print(" --------  -----------")
  print("  1) .75\"  1100")
  print("  2) 1\"    150")
  print("  3) 1¼\"   80")
  print("  4) 1½\"   24")
  print("  5) 1¾\"   15.5")
  print("  6) 2\"    8")
  print("  7) 2½\"   2")
  print("  8) 3\"    0.677")
  print("  9) 3½\"   0.34")
  print(" 10) 4\"    0.2")
  print(" 11) 4½\"   0.1")
  print(" 12) 5\"    0.08")
  print(" 13) 6\"    0.05")
  print(" ")

  choice = float(input("Enter hose size: "))
  gpm = float(input("Enter flow rate in GPM: "))
  hose = float(input("Enter the length of hose: "))

  def friction_loss(coefficient,gpm,hose): 

     step1 = float((gpm/100)**2)           # Gallons per minute in hundreds squared
     step2 = float(coefficient*step1)      # Multiply coefficient by gpm^2 
     step3 = float(hose/100)               # Hose Lenght in hundreds 
 
     if hose == 100:                    # If hose legnth is 100 we just skip    
         print "\nYour friction loss will be", step2, "psi."
     else:
         print "\nYour friction loss will be", step2 * step3, "psi."

  if choice == int(1):
     friction_loss(1100,gpm,hose)
  elif choice == int(2):
     friction_loss(150,gpm,hose)
  elif choice == int(3):
     friction_loss(80,gpm,hose)
  elif choice == int(4):
     friction_loss(24,gpm,hose)
  elif choice == int(5):
     friction_loss(15.5,gpm,hose)
  elif choice == int(6):
     friction_loss(8,gpm,hose)
  elif choice == int(7):
     friction_loss(2,gpm,hose)
  elif choice == int(8):
     friction_loss(0.677,gpm,hose)
  elif choice == int(9):
     friction_loss(0.34,gpm,hose)
  elif choice == int(10):
     friction_loss(0.2,gpm,hose)
  elif choice == int(11):
     friction_loss(0.1,gpm,hose)
  elif choice == int(12):
     friction_loss(0.08,gpm,hose)
  elif choice == int(13):
     friction_loss(0.05,gpm,hose) 

  print " "

  finished = raw_input("Calculate another? ")
  if finished != "y":
      print " "
      import sys
      sys.exit(0)
