# Todo Mobile

Legend:
- [not done] Not working
- [almost done] Working, not tested
- [done] Working, tested
- [done done] Working, tested, deployed as APK
- [done anyway] Working, deployed as APK, not tested


Time: around 13 hours


## 📝 Register 

- [x] [done] The user should be able to register with a username and password
  - [2 hours] Grabbed a boiler plate for Flutter user registration to make it work with Pow
  - [2 hours] Switched it to work with Guardian by passing UUID across Widgets


## 🚪 Login

- [x] [done] The user should be able to log in with the credentials they provided in the register endpoint
  - [4 hours] Fix https errors. Tried http, dio, and getx.
  


## 📓 Todo List

- [x] [done anyway] The user should only be able to access their own tasks
  - [0.5 hours] added filter in Ecto.query

- [x] [done anyway] The user should be able to list all tasks in the TODO list

- [x] [done anyway] The user should be able to add a task to the TODO list
  - [0.5 hours] added entryform
 
- [x] [done anyway] The user should be able to update the details of a task in their TODO list

- [x] [done anyway] The user should be able to remove a task from the TODO list

- [x] [done anyway] The user should be able to reorder the tasks in the TODO list
  - [1 hour] Went through Chris Mccords Todo App Demo
  - [3 hours] Tried Draggable lists, went with simpler Reorderlist instead 

- [x] [done anyway] A task in the TODO list should be able to handle being moved more than 50 times

- [x] [done anyway] A task in the TODO list should be able to handle being moved to more than one task away from its current position
  - built and uploaded APK
