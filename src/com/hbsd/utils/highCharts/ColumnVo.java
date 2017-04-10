package com.hbsd.utils.highCharts;

import java.util.ArrayList;

public class ColumnVo {
	private ArrayList<String> categories;

	private ArrayList<SeriesVo> series;

	
	public ArrayList<SeriesVo> getSeries() {
		return series;
	}

	public void setSeries(ArrayList<SeriesVo> series) {
		this.series = series;
	}

	public ArrayList<String> getCategories() {
		return categories;
	}

	public void setCategories(ArrayList<String> categories) {
		this.categories = categories;
	}
}
