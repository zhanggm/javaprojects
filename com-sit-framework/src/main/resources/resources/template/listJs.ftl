
Ext.define('Fes.view.${entityName}List', {
	extend : 'Ext.grid.Panel',
	alias : 'widget.${entityName?uncap_first}list',
	title : '角色列表',
 
	iconCls : 'icon-grid-list',
	rowLines : true,
	columnLines : true,
	multiSelect : true,
	simpleSelect : true,
	viewConfig : {
		loadingText : '正在加载人员列表'
	},
createRoleCombox:function(){
 
},
	columns : [	
	{xtype : 'rownumberer'}, 
				<#list columns as po>
					{text : '${po.filedComment}',width : 120,sortable : true,dataIndex : '${po.fieldName}',field : {xtype : 'textfield',required : true}},
	 	 		</#list>
	 	 		
	 	 		{text : 'id',width : 120,sortable : true,dataIndex : 'id',hidden:true}
	 	 		
	],
	initComponent : function() {
	 
		this.createStore();
		 
		this.rowEditor = Ext.create('Ext.grid.plugin.RowEditing', {
				id:'${entityName?uncap_first}ListRowEditor',
				listeners : {
					beforeedit:function( editor,  e,  eOpts ){
					},
					startEdit:function(record, columnHeader ){
			
						this.editRecord=record;
					},
					edit : function(editor, e) {
					 
						e.record.save({
									success : function(${entityName?uncap_first}, options) {
										var data = Ext.decode(options.response.responseText);
										if (data.extra) {
											${entityName?uncap_first}.set('id', data.extra);
										}
										${entityName?uncap_first}.commit();
									}
								});
	
					}
				}
			});
		 
		;
		this.plugins = [this.rowEditor], this.tbar = this.createToolbar();
		this.bbar = {
			xtype : 'pagingtoolbar',
			store : this.store,
			displayInfo : true
		};
		this.callParent();
		
	},

	createStore : function() {
		var me = this;
		me.store = Ext.create('Fes.store.${entityName}Store');
	},

	addRecord : function() {
		var records = this.getSelectionModel().getSelection();
		var record = new Fes.model.${entityName}Model({
			
		});

		if (records.length > 0){
			// record =	records[records.length-1];
			record= new Fes.model.${entityName}Model({
			
					<#list columns as po>
						${po.fieldName}:records[records.length-1].data.${po.fieldName},
				 	
					</#list>
 
								});
		}
		
	
		this.getStore().add(record);
		this.rowEditor.startEdit(record, 1);
	},

	deleteRecord : function() {
		var me = this;
		var records = this.getSelectionModel().getSelection();
		if (records.length > 0) {
			Fes.MsgBox.confirm('确定删除这' + records.length + '个${ftl_description}?',
					function(btn) {
						Ext.each(records, function(record) {
									if (Ext.Array.contains(me.getStore()
													.getNewRecords(), record)) {
										me.getStore().remove(record);
									} else {
										record.destroy({
													success : function() {
														me.store.remove(record);
													}
												});
									}
								});
					});
		}

	},

	createToolbar : function() {
		var me = this;
		return Ext.create('Ext.toolbar.Toolbar', {
					items : [{
								xtype : 'textfield',
								fieldLabel : 'ID',
								labelWidth : 40,
								flex : .6,
								id : '${entityName?uncap_first}Id'
							},{
								xtype : 'button',
								text : '查询',
								iconCls : 'icon-search',
								handler : function() {
									me.getStore().load({
										params : {
											id : Ext.getCmp('${entityName?uncap_first}Id').getValue()
										}
									});
								}
							}, '-', Ext.create('Ext.Button', {
										text : '添加',
										iconCls : 'icon-add',
										handler : me.addRecord,
										scope : me
									}),  '-', {
								xtype : 'button',
								text : '删除',
								iconCls : 'icon-del',
								handler : me.deleteRecord,
								scope : me
							}]
				});
	}
});