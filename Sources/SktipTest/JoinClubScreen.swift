import SkipFuseUI

struct JoinClubScreen: View {
    @Environment(\.customDismiss) var customDismiss

    @State var displayName: String = ""
    @State var searchQuery: String = ""
    @State var inviteCode: String = ""

    @State var searchResults: [Club] = []
    @State var selectedClub: Club?

    @State var isLoadingSearch: Bool = false
    @State var isLoadingJoin: Bool = false
    @State var errorMessage: String?

    var isFormValid: Bool {
        !displayName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        selectedClub != nil &&
        (selectedClub?.isPrivate == false || (selectedClub?.isPrivate == true && !inviteCode.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty))
    }

    var body: some View {
        FormSheetView(
            title: {
                Text("Join Club")
            },
            body: {
                mainBodyContent
            },
            footer: {
                FormActionButton(
                    title: "Join Club",
                    isLoading: isLoadingJoin,
                    isDisabled: !isFormValid || isLoadingJoin
                ) {
                    Task {
                        await performJoinClub()
                    }
                }
            }
        )
    }

    private var mainBodyContent: some View {
        Form {
            userDetailsSection
            findClubSection
            inviteCodeSection // This is now a @ViewBuilder, handles optionality
            errorDisplaySection // This is now a @ViewBuilder, handles optionality
        }
    }

    private var userDetailsSection: some View {
        Section(header: Text("Your Details")) {
            TextField("Display Name", text: $displayName)
                .autocorrectionDisabled(true) // Autocorrection is fine
        }
    }

    private var findClubSection: some View {
        Section(header: Text("Find a Club")) {
            VStack {
                searchSectionHeader

                if isLoadingSearch {
                    loadingView
                } else if !searchResults.isEmpty {
                    searchResultList
                } else if !searchQuery.isEmpty {
                    Text("Nothing found")
                }
            }
        }
    }

    private var loadingView: some View {
        VStack {
            ProgressView()
            Text("Searching clubs...")
                .foregroundColor(Color.secondaryText)
        }
    }

    private var searchSectionHeader: some View {
        HStack {
            TextField("Search by club name", text: $searchQuery)
                .autocorrectionDisabled(true)
            Button(action: {
                Task { await performSearchClubs() }
            }) {
                if isLoadingSearch {
                    ProgressView()
                        .progressViewStyle(.circular) // Explicit style
                } else {
                    Image(systemName: "magnifyingglass")
                }
            }
            .disabled(searchQuery.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || isLoadingSearch)
        }
    }

    private var searchResultList: some View {
        LazyVStack {
            ForEach(searchResults) { club in
                ClubSearchRow(
                    club: club,
                    isSelected: selectedClub?.id == club.id
                ) {
                    Task { selectClub(club) }
                }
            }
        }
    }

    private var noClubsFoundSection: some View {
        Text("No clubs found for \"\(searchQuery)\".")
            .foregroundColor(Color.secondaryText)
            .font(.caption) // Using caption for less prominent text
    }

    @ViewBuilder
    private var inviteCodeSection: some View {
        if let club = selectedClub, club.isPrivate {
            Section(header: Text("Private Club Access for \(club.name)")) { // Added club name for clarity
                TextField("Invite Code", text: $inviteCode)
                    .autocorrectionDisabled(true)
                    // REMOVE: .autocapitalization(.none) - not supported
            }
            .transition(.opacity.combined(with: .move(edge: .top))) // Animation
        }
    }

    @ViewBuilder
    private var errorDisplaySection: some View {
        if let errorMessage, !errorMessage.isEmpty {
            Section {
                Text(errorMessage)
                    .foregroundColor(Color.error)
            }
        }
    }

    @MainActor
    private func selectClub(_ club: Club) {
        if selectedClub?.id == club.id {
            selectedClub = nil // Deselect if tapped again
            inviteCode = ""   // Clear invite code
        } else {
            selectedClub = club
            // Clear invite code if new club is public
            if !club.isPrivate {
                inviteCode = ""
            }
        }
    }

    @MainActor
    private func performSearchClubs() async {
    }

    @MainActor
    private func performJoinClub() async {
    }
}

// Helper view for displaying club search results (internal access level)
struct ClubSearchRow: View {
    let club: Club
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: AppSpacing.Spacing.extraSmall) {
                Text(club.name)
                    .font(.headline) // Using SkipFuseUI's font system
                    .foregroundColor(Color.text) // Using project's color definition

                HStack(spacing: AppSpacing.Spacing.small) {
                    Text(club.isPrivate ? "Private" : "Public")
                        .font(.caption)
                        .foregroundColor(Color.secondaryText)

                    Text("•") // Separator
                        .font(.caption)
                        .foregroundColor(Color.secondaryText)

                    // Assuming club.createdAt is a Date
                    Text("Created: \(formatDate(club.createdAt))")
                        .font(.caption)
                        .foregroundColor(Color.secondaryText)
                }
            }

            Spacer() // Pushes content to sides

            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(Color.accent)
                    .font(.system(size: AppSpacing.IconSize.small)) // Standard system font size for icon
            }
        }
        .padding(.vertical, AppSpacing.Padding.small) // Standard padding
        .onTapGesture { // Make the row tappable
            onTap()
        }
    }

    // Date formatter (private as it's only used here)
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}
