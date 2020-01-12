theme_bari <- function() {
  theme_minimal() +
    theme(
      panel.grid.major.y = element_line(
        size = .75
      ),
      panel.grid = element_line(),
      panel.border = element_rect(size = .5, fill = NA, color = "#524d4d"),
      text = element_text(family = "HelveticaNeue-CondensedBold"),
      plot.title = element_text(color = "#8d0909", size = 24),
      plot.subtitle = element_text(color = "#2e2828", size = 18),
      plot.caption = element_text(
        color = "#524d4d", size = 8,
        hjust = 1,
        margin = margin(t = 10),
        family = "Avenir Next Condensed Medium"
      )
    )
  
}
