import SwiftUI
import SwiftData

struct NoteView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var noteTitle = ""
    @State private var noteContent = ""
    var initiative: Initiative
    var note: InitiativeNote?
    
    init(initiative: Initiative, note: InitiativeNote? = nil) {
        self.initiative = initiative
        self.note = note
        if let note = note {
            _noteTitle = State(initialValue: note.title)
            _noteContent = State(initialValue: note.content)
        }
    }
    
    var body: some View {
        VStack {
            TextField("Title", text: $noteTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextEditor(text: $noteContent)
                .frame(minHeight: 300)
                .frame(minWidth: 300)
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
            
            HStack {
                if note != nil {
                    Button(action: {
                        if let note = note, var notes = initiative.notes {
                            notes.removeAll { $0 == note }
                            initiative.notes = notes
                            try? modelContext.save()
                        }
                        dismiss()
                    }) {
                        Text("Delete")
                            .font(.title2)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red.opacity(0.4))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: {
                        if let note = note {
                            note.title = noteTitle
                            note.content = noteContent
                            try? modelContext.save()
                        }
                        dismiss()
                    }) {
                        Text("Back")
                            .font(.title2)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.teal.opacity(0.4))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                } else {
                    Button(action: {
                        let newNote = InitiativeNote(title: noteTitle, content: noteContent)
                        initiative.notes?.append(newNote)
                        try? modelContext.save()
                        dismiss()
                    }) {
                        Text("Save")
                            .font(.title2)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue.opacity(0.4))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    
                    Spacer()
                    
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Discard")
                            .font(.title2)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.teal.opacity(0.4))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .padding()
    }
}
