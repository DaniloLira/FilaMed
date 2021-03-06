import CoreData

struct AppointmentManager {
    static let shared = AppointmentManager()

    func create(date: Date, time: String, status: AppointmentStatus) -> Appointment? {

        let appointmentObject = NSEntityDescription.insertNewObject(forEntityName: "Appointment", into: coreDataContext)

        guard let appointment =  appointmentObject as? Appointment else {
            fatalError("Could not find Appointment class")
        }

        appointment.date = date
        appointment.time = time
        appointment.status = status.rawValue

        return self.save() ? appointment : nil
    }

    func getBy(attribute: String, type: String) -> [Appointment]? {
        let fetchRequest = NSFetchRequest<Appointment>(entityName: "Appointment")
        fetchRequest.predicate = NSPredicate(format: "to.\(type) == %@", attribute)

        do {
            let appointments = try coreDataContext.fetch(fetchRequest)
            return appointments
        } catch let error {
            print("We Couldn't find the appointment. \n \(error)")
        }

        return nil
    }

    func count() -> Int {
        let fetchRequest = NSFetchRequest<Appointment>(entityName: "Appointment")

        do {
            return try coreDataContext.count(for: fetchRequest)
        } catch {
            return 0
        }
    }

    func getAll() -> [Appointment]? {
        let fetchRequest = NSFetchRequest<Appointment>(entityName: "Appointment")

        do {
            let appointments = try coreDataContext.fetch(fetchRequest)
            return appointments
        } catch {
            print("Something happened try again later.")
        }

        return nil
    }

    func delete(name: String) -> Bool {
        let fetchRequest = NSFetchRequest<Appointment>(entityName: "Appointment")

        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)

        do {
            let appointment = try coreDataContext.fetch(fetchRequest)

            if !appointment.isEmpty {
                coreDataContext.delete(appointment[0])
                return self.save()
            } else {
                print("This appointment could not be found")
            }

        } catch {
            print("Error")
        }

        return false
    }

    func save() -> Bool {
        do {
            try coreDataContext.save()
            return true
        } catch let error {
            print("Sorry, we can't save the appointment. Try again later. \n \(error)")
        }

        return false
    }
}

enum AppointmentStatus: String {
    case line = "Você pode entrar na fila"
    case documents = "Você já pode entregar os documentos"
    case waiting = "Aguarde o momento de sair de casa"
    case arrived = "Você chegou ao local, espere seu atendimento"
}
