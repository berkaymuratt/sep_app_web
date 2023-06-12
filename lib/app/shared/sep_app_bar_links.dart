enum SepAppBarLinks {
  APPOINTMENTS,
  PATIENTS,
  REPORTS,
}

final Map<SepAppBarLinks, String> _links = {
  SepAppBarLinks.APPOINTMENTS: "Randevularım",
  SepAppBarLinks.PATIENTS: "Hastalarım",
  SepAppBarLinks.REPORTS: "Raporlarım",
};

class SepAppBarState {
  SepAppBarLinks? activeLink;

  SepAppBarState({this.activeLink});

  bool isLinkActive(String linkTitle) {

    if (activeLink != null && linkTitle == _links[activeLink]) {
      return true;
    } else {
      return false;
    }
  }
}
