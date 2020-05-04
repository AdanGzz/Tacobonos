(define-keyset 'root (read-keyset 'root))

(module tacobono 'root
  
  (defschema autoint-schema
    Last:integer)

  (deftable 
    autoint-table:{autoint-schema})

  (defschema tacobonos-schema
    ID_user:integer
    Type:integer
    Status:integer
    Date:time)

  (deftable
    tacobonos-table:{tacobonos-schema})

  (defschema admins-schema
    Charge:string
    Type:integer
    Active:bool
    Roll:integer
    Key:keyset)

  (deftable
    admins-table:{admins-schema})

  (defschema users-schema
    Key:keyset
    Name:string
    Roll:integer
    Active:bool)

  (deftable
    users-table:{users-schema})

  (defun create-tacobono (ID_User:integer Type:integer Status:integer Date:time)
    "Create tacobono"
    (with-read autoint-table 'tacobonos {'Last := last}
      (insert tacobonos-table (format "{}" [last]) {"ID_User":ID_User, "Type":Type, "Status":Status, "Date":Date})
      (write autoint-table 'tacobonos {'Last : (+ 1 last)})
      (format "Tacobono successfully registered with ID: {}" [last])
    )
  )

  (defun activate-tacobono (id:integer user:integer)
    (update tacobonos-table (format "{}" [id]) {"ID_User":user, "State":1})
  )

  (defun deactivate-tacobono (id:integer)
    (update tacobonos-table (format "{}" [id]) {"ID_User":0, "State":5})
  )

  (defun assign-tacobono (id:integer user:integer)
    (update tacobonos-table (format "{}" [id]) {"ID_User":user, "State":2})
  )

  (defun change-tacobono (id:integer)
    (update tacobonos-table (format "{}" [id]) {"State":3})
  )

  (defun expire-tacobono (id:integer)
    (update tacobonos-table (format "{}" [id]) {"State":4})
  )

  (defun create-admin (Charge:string Type:integer Roll:integer Key:keyset)
    "Create an admin"
    (with-red autoint-table 'admins {'Last := last}
      (insert admins-table (format "{}" [last]) {"Charge":Charge, "Type":Type, "Active":true, "Roll":Roll, "Key":Key})
      (write autoint-table 'admins {'Last : (+ 1 last)})
      (format "Admin successfully registered with ID {}" [last])
    )
  )

  (defun deactivate-admin (id:integer)
    (update admins-table (format "{}" [id]) {"Active":false})
  )

  (defun reactivate-admin (id:integer)
    (update admins-table (format "{}" [id]) {"Active":true})
  )

  (defun update-charge-admin (id:integer Charge:string)
    (update admins-table (format "{}" [id]) {"Charge":Charge})
  )

  (defun update-roll-admin (id:integer roll:integer)
    (update admins-table (format "{}" [id]) {"Roll":roll})
  )

  (defun update-type-admin (id:integer Type:integer)
    (update admins-table (format "{}" [id]) {"Type":Type})
  )

  (defun update-key-admin (id:integer key:keyset)
    (update admins-table (format "{}" [id]) {"Key":key})
  )

  (defun create-user (key:keyset name:string roll:integer)
    "Sign up user"
    (with-read autoint-table 'users {'Last := last}
      (insert users-table (format "{}" [last]) {"Key":key, "Name":name, "Roll":roll, "Active":true})
      (write autoint-table 'users {'Last : (+ 1 last)})
      (format "User successfully registered with ID: {}" [last])
    )
  )

  (defun deactivate-user (id:integer)
    (update users-table (format "{}" [id]) {"Active":false})
  )

  (defun reactivate-user (id:integer)
    (update users-table (format "{}" [id]) {"Active":true})
  )

  (defun update-name-user (id:integer name:string)
    (update users-table (format "{}" [id]) {"Name":name})
  )

  (defun update-roll-user (id:integer roll:integer)
    (update users-table (format "{}" [id]) {"Roll":roll})
  )

  (defun update-key-user (id:integer key:keyset)
    (update users-table (format "{}" [id]) {"Key":key})
  )
)

(create-table autoint-table)
(create-table tacobonos-table)
(create-table admins-table)
(create-table users-table)

(insert autoint-table "tacobonos" {'Last:1})
(insert autoint-table "admins" {'Last:1})
(insert autoint-table "users" {'Last:1})
